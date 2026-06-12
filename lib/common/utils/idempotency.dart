import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Idempotency {
  static const String _storageKey = 'pending_idempotency_requests';
  static const String processingMessage = 'request still processing';
  static const String headerName = 'X-Request-Id';
  static const Duration _maxPendingAge = Duration(days: 7);
  static const Duration? testReceiveTimeout = null;
  // static const Duration? testReceiveTimeout = Duration(milliseconds: 5);

  static Future<String> getOrCreate({
    required String endpoint,
    required Map<String, dynamic> fingerprintData,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final records = _loadRecords(prefs);
    _pruneExpired(records);
    final fingerprint = fingerprintFor(fingerprintData);
    final key = _recordKey(endpoint, fingerprint);
    final existing = records[key];
    if (existing is Map && existing['requestId'] is String) {
      final requestId = (existing['requestId'] as String).trim();
      if (requestId.isNotEmpty) {
        return requestId;
      }
    }

    final requestId = const Uuid().v4();
    records[key] = {
      'endpoint': endpoint,
      'fingerprint': fingerprint,
      'requestId': requestId,
      'createdAt': DateTime.now().toIso8601String(),
    };
    await prefs.setString(_storageKey, jsonEncode(records));
    return requestId;
  }

  static Future<void> clear(String endpoint, String requestId) async {
    final prefs = await SharedPreferences.getInstance();
    final records = _loadRecords(prefs);
    records.removeWhere((_, value) {
      if (value is! Map) return false;
      return value['endpoint'] == endpoint && value['requestId'] == requestId;
    });
    if (records.isEmpty) {
      await prefs.remove(_storageKey);
      return;
    }
    await prefs.setString(_storageKey, jsonEncode(records));
  }

  static Future<void> clearIfFinal(
    String endpoint,
    String requestId,
    dynamic response,
  ) async {
    if (!isProcessingResponse(response)) {
      await clear(endpoint, requestId);
    }
  }

  static bool isProcessingResponse(dynamic response) {
    if (response is! Map) return false;
    final code = response['code'];
    final msg = response['msg']?.toString().trim().toLowerCase();
    return code != 0 && msg == processingMessage;
  }

  static String fingerprintFor(Map<String, dynamic> data) {
    return jsonEncode(_stableValue(data));
  }

  static Map<String, dynamic> _loadRecords(SharedPreferences prefs) {
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return <String, dynamic>{};
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } catch (_) {}
    return <String, dynamic>{};
  }

  static String _recordKey(String endpoint, String fingerprint) {
    return '$endpoint::$fingerprint';
  }

  static void _pruneExpired(Map<String, dynamic> records) {
    final now = DateTime.now();
    records.removeWhere((_, value) {
      if (value is! Map) return true;
      final createdAt = DateTime.tryParse(value['createdAt']?.toString() ?? '');
      if (createdAt == null) return true;
      return now.difference(createdAt) > _maxPendingAge;
    });
  }

  static dynamic _stableValue(dynamic value) {
    if (value is Map) {
      final entries = value.entries.toList()
        ..sort((a, b) => a.key.toString().compareTo(b.key.toString()));
      return {
        for (final entry in entries)
          entry.key.toString(): _stableValue(entry.value),
      };
    }
    if (value is List) {
      return value.map(_stableValue).toList();
    }
    return value;
  }
}
