import 'dart:convert';

import 'package:app/common/entities/entities.dart';
import 'package:app/common/services/storage.dart';
import 'package:app/common/values/constant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeSecureStorage implements SecureStorageAdapter {
  final Map<String, String> values = {};

  @override
  Future<void> delete(String key) async {
    values.remove(key);
  }

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async {
    values[key] = value;
  }
}

class FailingSecureStorage extends FakeSecureStorage {
  @override
  Future<void> write(String key, String value) {
    throw StateError('Secure storage unavailable');
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('migrates the existing token and device UUID before removing them',
      () async {
    SharedPreferences.setMockInitialValues({
      STORAGE_USER_TOKEN_KEY: 'legacy-token',
      STORAGE_LOGIN_DEVICE_ID_KEY: 'legacy-device-id',
    });
    final secureStorage = FakeSecureStorage();
    final storage = await StorageService(secureStorage: secureStorage).init();
    final preferences = await SharedPreferences.getInstance();

    expect(storage.getUserToken(), 'legacy-token');
    expect(storage.getLoginDeviceId(), 'legacy-device-id');
    expect(storage.getIsLogin(), isTrue);
    expect(secureStorage.values[STORAGE_USER_TOKEN_KEY], 'legacy-token');
    expect(
      secureStorage.values[STORAGE_LOGIN_DEVICE_ID_KEY],
      'legacy-device-id',
    );
    expect(preferences.getString(STORAGE_USER_TOKEN_KEY), isNull);
    expect(preferences.getString(STORAGE_LOGIN_DEVICE_ID_KEY), isNull);
  });

  test('reuses a generated device UUID across service initialization',
      () async {
    SharedPreferences.setMockInitialValues({});
    final secureStorage = FakeSecureStorage();
    final firstStorage =
        await StorageService(secureStorage: secureStorage).init();
    final firstDeviceId = await firstStorage.getOrCreateLoginDeviceId();

    final secondStorage =
        await StorageService(secureStorage: secureStorage).init();
    final secondDeviceId = await secondStorage.getOrCreateLoginDeviceId();

    expect(firstDeviceId, isNotEmpty);
    expect(secondDeviceId, firstDeviceId);
  });

  test('moves a profile-only access token and removes cached credentials',
      () async {
    final legacyProfile = jsonEncode({
      'access_token': 'profile-token',
      'token': 'unused-backend-token',
      'first_name': 'Agent',
      'is_main_device': true,
    });
    SharedPreferences.setMockInitialValues({
      STORAGE_USER_PROFILE_KEY: legacyProfile,
    });
    final secureStorage = FakeSecureStorage();
    final storage = await StorageService(secureStorage: secureStorage).init();
    final preferences = await SharedPreferences.getInstance();
    final cachedProfile = jsonDecode(
      preferences.getString(STORAGE_USER_PROFILE_KEY)!,
    ) as Map<String, dynamic>;

    expect(storage.getUserToken(), 'profile-token');
    expect(secureStorage.values[STORAGE_USER_TOKEN_KEY], 'profile-token');
    expect(cachedProfile.containsKey('access_token'), isFalse);
    expect(cachedProfile.containsKey('token'), isFalse);
    expect(cachedProfile['first_name'], 'Agent');
    expect(cachedProfile['is_main_device'], isTrue);
    await expectLater(
      storage.setString(
        STORAGE_USER_PROFILE_KEY,
        jsonEncode({'access_token': 'bypass-attempt'}),
      ),
      throwsArgumentError,
    );
  });

  test('new profile writes never contain credential fields', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await StorageService(
      secureStorage: FakeSecureStorage(),
    ).init();
    final preferences = await SharedPreferences.getInstance();

    await storage.setUserProfile(
      UserItem(
        accessToken: 'must-not-be-cached',
        firstName: 'Agent',
        isMainDevice: true,
      ),
    );
    final cachedProfile = jsonDecode(
      preferences.getString(STORAGE_USER_PROFILE_KEY)!,
    ) as Map<String, dynamic>;

    expect(cachedProfile.containsKey('access_token'), isFalse);
    expect(cachedProfile.containsKey('token'), isFalse);
    expect(cachedProfile['first_name'], 'Agent');
    expect(cachedProfile['is_main_device'], isTrue);
  });

  test('keeps legacy values when secure migration fails', () async {
    SharedPreferences.setMockInitialValues({
      STORAGE_USER_TOKEN_KEY: 'legacy-token',
    });
    final storage = StorageService(secureStorage: FailingSecureStorage());

    await expectLater(storage.init(), throwsStateError);

    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString(STORAGE_USER_TOKEN_KEY), 'legacy-token');
  });

  test('keeps a legacy profile unchanged when token migration fails', () async {
    final legacyProfile = jsonEncode({
      'access_token': 'profile-token',
      'token': 'unused-backend-token',
      'first_name': 'Agent',
    });
    SharedPreferences.setMockInitialValues({
      STORAGE_USER_PROFILE_KEY: legacyProfile,
    });
    final storage = StorageService(secureStorage: FailingSecureStorage());

    await expectLater(storage.init(), throwsStateError);

    final preferences = await SharedPreferences.getInstance();
    expect(
      preferences.getString(STORAGE_USER_PROFILE_KEY),
      legacyProfile,
    );
  });

  test('stores login state securely and logout preserves the device UUID',
      () async {
    SharedPreferences.setMockInitialValues({});
    final secureStorage = FakeSecureStorage();
    final storage = await StorageService(secureStorage: secureStorage).init();
    final deviceId = await storage.getOrCreateLoginDeviceId();

    await storage.setUserToken('access-token');
    expect(storage.getUserToken(), 'access-token');
    expect(storage.getIsLogin(), isTrue);

    await storage.removeUserToken();
    expect(storage.getUserToken(), isEmpty);
    expect(storage.getIsLogin(), isFalse);
    expect(storage.getLoginDeviceId(), deviceId);
    expect(secureStorage.values[STORAGE_USER_TOKEN_KEY], isNull);
    expect(secureStorage.values[STORAGE_LOGIN_DEVICE_ID_KEY], deviceId);
  });
}
