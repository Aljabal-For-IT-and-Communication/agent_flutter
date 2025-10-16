part of 'bloc.dart';

class ChangePasswordState {
  const ChangePasswordState({
    this.password = "",
    this.repassword = "",
    this.confirm_password = "",
  });

  final String password;
  final String repassword;
  final String confirm_password;

  ChangePasswordState copyWith({
    String? password,
    String? repassword,
    String? confirm_password,
  }) {
    return ChangePasswordState(
      password: password ?? this.password,
      repassword: repassword ?? this.repassword,
      confirm_password: confirm_password ?? this.confirm_password,
    );
  }
}
