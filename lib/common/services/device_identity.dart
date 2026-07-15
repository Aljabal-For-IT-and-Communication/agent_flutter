import 'dart:io';

import 'package:app/global.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceIdentityService {
  static Map<String, dynamic>? _cachedIdentity;
  static Future<Map<String, dynamic>>? _pendingIdentity;

  static Future<Map<String, dynamic>> collect() async {
    final cached = _cachedIdentity;
    if (cached != null) return cached;

    final pending = _pendingIdentity;
    if (pending != null) return pending;

    final future = _collect();
    _pendingIdentity = future;
    try {
      return await future;
    } finally {
      _pendingIdentity = null;
    }
  }

  static Future<Map<String, dynamic>> _collect() async {
    final appUuid = await Global.storageService.getOrCreateLoginDeviceId();
    final plugin = DeviceInfoPlugin();

    if (Platform.isIOS) {
      final ios = await plugin.iosInfo;
      return _cachedIdentity = {
        'app_uuid': appUuid,
        'platform': 'ios',
        'device_name': _firstNotEmpty([ios.name, ios.modelName, ios.model]),
        'manufacturer': 'Apple',
        'model':
            _firstNotEmpty([ios.modelName, ios.utsname.machine, ios.model]),
      };
    }

    if (Platform.isAndroid) {
      final android = await plugin.androidInfo;
      return _cachedIdentity = {
        'app_uuid': appUuid,
        'platform': 'android',
        'device_name': _firstNotEmpty([android.name, android.model]),
        'manufacturer': _firstNotEmpty([android.manufacturer, android.brand]),
        'model': _firstNotEmpty([android.model, android.device]),
      };
    }

    throw UnsupportedError('Unsupported device platform');
  }

  static String _firstNotEmpty(List<String?> values) {
    for (final value in values) {
      final trimmed = value?.trim();
      if (trimmed != null && trimmed.isNotEmpty) return trimmed;
    }
    return 'Unknown';
  }
}
