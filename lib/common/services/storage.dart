import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/values/constant.dart';

abstract class SecureStorageAdapter {
  Future<String?> read(String key);

  Future<void> write(String key, String value);

  Future<void> delete(String key);
}

class PlatformSecureStorageAdapter implements SecureStorageAdapter {
  PlatformSecureStorageAdapter()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock_this_device,
          ),
        );

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}

class StorageService {
  StorageService({SecureStorageAdapter? secureStorage})
      : _secureStorage = secureStorage ?? PlatformSecureStorageAdapter();

  late final SharedPreferences _prefs;
  final SecureStorageAdapter _secureStorage;
  String _userToken = '';
  String _loginDeviceId = '';

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    _userToken = await _migrateSensitiveValue(STORAGE_USER_TOKEN_KEY);
    await _migrateLegacyUserProfile();
    _loginDeviceId = await _migrateSensitiveValue(
      STORAGE_LOGIN_DEVICE_ID_KEY,
    );
    return this;
  }

  Future<String> _migrateSensitiveValue(String key) async {
    final secureValue = (await _secureStorage.read(key))?.trim() ?? '';
    if (secureValue.isNotEmpty) {
      await _prefs.remove(key);
      return secureValue;
    }

    final legacyValue = (_prefs.getString(key) ?? '').trim();
    if (legacyValue.isEmpty) {
      return '';
    }

    await _secureStorage.write(key, legacyValue);
    await _prefs.remove(key);
    return legacyValue;
  }

  Future<void> _migrateLegacyUserProfile() async {
    final rawProfile = _prefs.getString(STORAGE_USER_PROFILE_KEY) ?? '';
    if (rawProfile.trim().isEmpty) return;

    late final Map<String, dynamic> profileData;
    try {
      final decoded = jsonDecode(rawProfile);
      if (decoded is! Map) {
        await _prefs.remove(STORAGE_USER_PROFILE_KEY);
        return;
      }
      profileData = Map<String, dynamic>.from(decoded);
    } on FormatException {
      await _prefs.remove(STORAGE_USER_PROFILE_KEY);
      return;
    }

    final profileToken = profileData['access_token']?.toString().trim() ?? '';
    if (_userToken.isEmpty && profileToken.isNotEmpty) {
      await _secureStorage.write(STORAGE_USER_TOKEN_KEY, profileToken);
      _userToken = profileToken;
      await _prefs.remove(STORAGE_USER_TOKEN_KEY);
    }

    final containedCredentials = profileData.containsKey('access_token') ||
        profileData.containsKey('token');
    if (!containedCredentials) return;

    profileData.remove('access_token');
    profileData.remove('token');
    final didPersist = await _prefs.setString(
      STORAGE_USER_PROFILE_KEY,
      jsonEncode(profileData),
    );
    if (!didPersist) {
      throw StateError('Could not remove credentials from the cached profile.');
    }
  }

  Future<bool> setString(String key, String value) async {
    if (key == STORAGE_USER_TOKEN_KEY || key == STORAGE_LOGIN_DEVICE_ID_KEY) {
      throw ArgumentError('Use the secure storage methods for $key.');
    }
    if (key == STORAGE_USER_PROFILE_KEY) {
      throw ArgumentError('Use setUserProfile for $key.');
    }
    return await _prefs.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  String getString(String key) {
    if (key == STORAGE_USER_TOKEN_KEY || key == STORAGE_LOGIN_DEVICE_ID_KEY) {
      throw ArgumentError('Use the secure storage methods for $key.');
    }
    return _prefs.getString(key) ?? '';
  }

  bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  List<String> getList(String key) {
    return _prefs.getStringList(key) ?? [];
  }

  Future<bool> remove(String key) async {
    if (key == STORAGE_USER_TOKEN_KEY || key == STORAGE_LOGIN_DEVICE_ID_KEY) {
      throw ArgumentError('Use the secure storage methods for $key.');
    }
    return await _prefs.remove(key);
  }

  String getUserToken() {
    return _userToken;
  }

  Future<void> setUserToken(String value) async {
    final normalizedValue = value.trim();
    await _secureStorage.write(STORAGE_USER_TOKEN_KEY, normalizedValue);
    _userToken = normalizedValue;
    await _prefs.remove(STORAGE_USER_TOKEN_KEY);
  }

  Future<void> removeUserToken() async {
    _userToken = '';
    await _secureStorage.delete(STORAGE_USER_TOKEN_KEY);
    await _prefs.remove(STORAGE_USER_TOKEN_KEY);
  }

  Future<bool> setUserProfile(UserItem profile) async {
    final profileData = profile.toJson()
      ..remove('access_token')
      ..remove('token');
    return _prefs.setString(
      STORAGE_USER_PROFILE_KEY,
      jsonEncode(profileData),
    );
  }

  String getLanguage() {
    return _prefs.getString(STORAGE_LANGUAGE_CODE) ?? "";
  }

  Future<bool> setLanguage(String value) async {
    return await _prefs.setString(STORAGE_LANGUAGE_CODE, value);
  }

  Future<String> getOrCreateLoginDeviceId() async {
    if (_loginDeviceId.isNotEmpty) {
      return _loginDeviceId;
    }

    final newDeviceId = const Uuid().v4();
    await _secureStorage.write(STORAGE_LOGIN_DEVICE_ID_KEY, newDeviceId);
    _loginDeviceId = newDeviceId;
    await _prefs.remove(STORAGE_LOGIN_DEVICE_ID_KEY);
    return _loginDeviceId;
  }

  String getLoginDeviceId() {
    return _loginDeviceId;
  }

  bool getDeviceFirstOpen() {
    return _prefs.getBool(STORAGE_DEVICE_FIRST_OPEN_KEY) ?? false;
  }

  bool getCheck() {
    return _prefs.getBool(STORAGE_USER_CHECKED_KEY) ?? false;
  }

  bool getIsLogin() {
    return _userToken.isNotEmpty;
  }

  UserItem getUserProfile() {
    var profileOffline = _prefs.getString(STORAGE_USER_PROFILE_KEY) ?? "";
    if (profileOffline.isNotEmpty) {
      return UserItem.fromJson(jsonDecode(profileOffline));
    }
    return UserItem();
  }
}
