part of 'bloc.dart';

class SignInState {
  const SignInState({
    this.phone="",
    this.password="",
    this.isChecked=false,
  });

  final String password;
  final String phone;
  final bool isChecked;

  SignInState copyWith({
    String? password,
    String? phone,
    bool? isChecked,
  }) {
    return SignInState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
