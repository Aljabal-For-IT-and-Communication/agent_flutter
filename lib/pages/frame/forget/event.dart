part of 'bloc.dart';

abstract class ForgetEvent {
  const ForgetEvent();
}

class PhoneChanged extends ForgetEvent {
  const PhoneChanged(this.phone);

  final String phone;
}

class CountDownTimeChanged extends ForgetEvent {
  const CountDownTimeChanged(this.countDownTime);

  final int countDownTime;
}

class PasswordChanged extends ForgetEvent {
  const PasswordChanged(this.password);
  final String password;
}

class VerificationCodeChanged extends ForgetEvent {
  const VerificationCodeChanged(this.verificationCode);
  final String verificationCode;
}

class ConfirmPasswordChanged extends ForgetEvent {
  const ConfirmPasswordChanged(this.confirmPassword);
  final String confirmPassword;
}

class IsSendChanged extends ForgetEvent {
  const IsSendChanged(this.isSend);
  final bool isSend;
}
