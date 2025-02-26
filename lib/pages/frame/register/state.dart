part of 'bloc.dart';

class RegisterState {
  const RegisterState({
    this.firstName = "",
    this.middleName = "",
    this.lastName = "",
    this.city = "",
    this.area = "",
    this.phone = "",
    this.email = "",
    this.password = "",
    this.repassword = "",
  });

  final String firstName;
  final String middleName;
  final String lastName;
  final String city;
  final String area;
  final String phone;
  final String email;
  final String password;
  final String repassword;

  RegisterState copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? city,
    String? area,
    String? phone,
    String? email,
    String? password,
    String? repassword,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      city: city ?? this.city,
      area: area ?? this.area,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      repassword: repassword ?? this.repassword,
    );
  }
}
