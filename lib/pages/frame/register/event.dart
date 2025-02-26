part of 'bloc.dart';

abstract class RegisterEvent {
  const RegisterEvent();
}

class FirstNameChanged extends RegisterEvent {
  const FirstNameChanged(this.firstName);
  final String firstName;
}

class MiddleNameChanged extends RegisterEvent {
  const MiddleNameChanged(this.middleName);
  final String middleName;
}

class LastNameChanged extends RegisterEvent {
  const LastNameChanged(this.lastName);
  final String lastName;
}
class CityChanged extends RegisterEvent {
  const CityChanged(this.city);
  final String city;
}
class AreaChanged extends RegisterEvent {
  const AreaChanged(this.area);
  final String area;
}

class PhoneChanged extends RegisterEvent {
  const PhoneChanged(this.phone);
  final String phone;
}

class EmailChanged extends RegisterEvent {
  const EmailChanged(this.email);
  final String email;
}

class PasswordChanged extends RegisterEvent {
  const PasswordChanged(this.password);
  final String password;
}

class RePasswordChanged extends RegisterEvent {
  const RePasswordChanged(this.repassword);
  final String repassword;
}