import 'package:app/common/routes/names.dart';
import 'package:app/common/utils/i18n.dart';
import 'package:app/common/values/constant.dart';
import 'package:app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DeviceAuthorizationSession {
  static String? _invalidatedToken;

  static Future<void> handleResponse(Map<String, dynamic> response) async {
    final rawCode = response['code'];
    final code = rawCode is int ? rawCode : int.tryParse('$rawCode');
    if (code != 1401 && code != 1402 && code != 1403 && code != 1404) {
      return;
    }

    final token = Global.storageService.getUserToken();
    if (token.isEmpty || token == _invalidatedToken) return;
    _invalidatedToken = token;

    await Global.storageService.remove(STORAGE_USER_PROFILE_KEY);
    await Global.storageService.removeUserToken();

    final context = Global.navigatorKey.currentContext;
    if (context != null && context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.Sign_in,
        (Route<dynamic> route) => false,
      );
    }

    final message = response['msg']?.toString() ??
        'Access for this device was revoked. Ask the main device to authorize it again.';
    EasyLoading.showError(trServerMessage(message));
  }
}
