import 'dart:async';

import 'package:app/common/apis/apis.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/routes.dart';
import 'package:app/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/common/widgets/toast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'bloc.dart';

class Logic {
  final BuildContext context;
  Timer? _timer;

  Logic({
    required this.context,
  });


  handleForget() async{
    final state = context.read<ForgetBloc>().state;
    String phone = state.phone;
    String password = state.password;
    String confirmPassword = state.confirmPassword;
    String verificationCode = state.verificationCode;

    if(phone.isEmpty){
      toastInfo(msg: "phone number not empty!");
      return;
    }
    if(password.isEmpty){
      toastInfo(msg: "password not empty!");
      return;
    }
    if(password.length<6){
      toastInfo(msg: "New Password min length is 6!");
      return;
    }
    if(password != confirmPassword){
      toastInfo(msg: "New Password and Confirm password not Same !");
      return;
    }
    if(verificationCode.isEmpty){
      toastInfo(msg: "Verification Code not empty!");
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();

    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    ForgetPasswordRequestEntity entity =  ForgetPasswordRequestEntity();
    entity.password = state.password;
    entity.phone = state.phone;
    entity.verification_code = state.verificationCode;
    try {
      var result = await UserAPI.forgetPassword(params: entity);
      EasyLoading.dismiss();
      toastInfo(msg: "${result.msg}");
      if (result.code == 0) {
        toastInfo(msg: "Log back into your account！");
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.Sign_in, (Route<dynamic> route) => false);
      }
    } catch (e) {
      EasyLoading.dismiss();
      toastInfo(msg: 'internet error');
      Logger.write("${e}");
    }
  }

  handleSendCode() async{
    final state = context.read<ForgetBloc>().state;
    String phone = state.phone;
    bool isSend = state.isSend;

    if(phone.isEmpty){
      toastInfo(msg: "phone number not empty!");
      return;
    }
    if(isSend){
      toastInfo(msg: "Sending in ${state.countDownTime} seconds!");
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();

    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    VerificationRequestEntity entity =  VerificationRequestEntity();
    entity.phone = state.phone;
    try {
      var result = await UserAPI.sendCode(params: entity);
      EasyLoading.dismiss();

      if (result.code == 0) {
        toastInfo(msg: "Verification code send success！");
        //倒计时
        context.read<ForgetBloc>().add(CountDownTimeChanged(30));
        context.read<ForgetBloc>().add(IsSendChanged(true));
        startCountdownTimer();
      }else{
        toastInfo(msg: "${result.msg}");
      }
    } catch (e) {
      EasyLoading.dismiss();
      toastInfo(msg: 'internet error');
      Logger.write("${e}");
    }
  }

  void startCountdownTimer() {
    const oneSec = Duration(seconds: 1);

    callback(timer) {
      final state = context.read<ForgetBloc>().state;
      if (state.countDownTime < 1) {
        context.read<ForgetBloc>().add(IsSendChanged(false));
        _timer?.cancel();
      } else {
        var countDownTime = state.countDownTime - 1;
        context.read<ForgetBloc>().add(CountDownTimeChanged(countDownTime));

      }
    }

    _timer = Timer.periodic(oneSec, callback);
  }


}