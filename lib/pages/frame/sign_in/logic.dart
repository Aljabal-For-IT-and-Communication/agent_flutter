import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:app/common/apis/apis.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/routes.dart';
import 'package:app/common/utils/utils.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:app/global.dart';
import 'package:app/common/services/device_identity.dart';

import 'bloc.dart';

class Logic {
  final BuildContext context;

  Logic({
    required this.context,
  });

  asyncPostAllData() async {
    var state = context.read<SignInBloc>().state;
    if (state.phone.isEmpty) {
      toastInfo(msg: trServerMessage("Phone not empty!"));
      return;
    }
    if (state.password.isEmpty) {
      toastInfo(msg: trServerMessage("Password not empty!"));
      return;
    }
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    try {
      LoginRequestEntity loginRequestEntity = LoginRequestEntity();
      loginRequestEntity.password = state.password;
      loginRequestEntity.phone = state.phone;
      loginRequestEntity.device = await DeviceIdentityService.collect();
      FocusManager.instance.primaryFocus?.unfocus();
      var result = await UserAPI.Login(params: loginRequestEntity);
      if (!context.mounted) {
        EasyLoading.dismiss();
        return;
      }
      if (result.code == 0) {
        final user = result.data!;
        final accessToken = user.accessToken?.trim() ?? '';
        if (accessToken.isEmpty) {
          throw StateError('Login response did not include an access token.');
        }
        context.read<SignInBloc>().add(PasswordChanged(""));
        context.read<SignInBloc>().add(PhoneChanged(""));
        context.read<SignInBloc>().add(CheckChanged(false));
        await Global.storageService.setUserProfile(user);
        await Global.storageService.setUserToken(accessToken);
        EasyLoading.dismiss();
        if (!context.mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.Application, (Route<dynamic> route) => false);
      } else {
        EasyLoading.dismiss();
        toastInfo(msg: trServerMessage('${result.msg}'));
      }
    } catch (e) {
      EasyLoading.dismiss();
      toastInfo(msg: trServerMessage('internet error'));
      Logger.write("${e}");
    }
  }
}
