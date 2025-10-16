part of 'bloc.dart';

class ForgetState {
  const ForgetState({
    this.phone = "",
    this.verificationCode = "",
    this.password = "",
    this.confirmPassword = "",
    this.countDownTime = 0,
    this.isSend = false,
  });

  final String password;
  final String phone;
  final String verificationCode;
  final String confirmPassword;
  final int countDownTime;
  final bool isSend;

  ForgetState copyWith({
    String? password,
    String? phone,
    String? verificationCode,
    String? confirmPassword,
    int? countDownTime,
    bool? isSend,
  }) {
    return ForgetState(
      password: password ?? this.password,
      phone: phone ?? this.phone,
      verificationCode: verificationCode ?? this.verificationCode,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      countDownTime: countDownTime ?? this.countDownTime,
      isSend: isSend ?? this.isSend,
    );
  }
}
