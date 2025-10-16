part of 'bloc.dart';

abstract class SignInEvent {
  const SignInEvent();
}

class PhoneChanged extends SignInEvent {
  final String phone;
  const PhoneChanged(this.phone);
}

class PasswordChanged extends SignInEvent {
  final String password;
  const PasswordChanged(this.password);
}

class CheckChanged extends SignInEvent {
  final bool? isChecked;
  const CheckChanged(this.isChecked);
}
