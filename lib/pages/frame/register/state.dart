part of 'bloc.dart';

class RegisterState {
  const RegisterState({
    this.firstName = "",
    this.middleName = "",
    this.lastName = "",
    this.businessName = "",
    this.address = "",
    this.phone = "",
    this.email = "",
    this.password = "",
    this.repassword = "",
    this.machineNumber = "",
  });

  final String firstName;
  final String middleName;
  final String lastName;
  final String businessName;
  final String address;
  final String phone;
  final String email;
  final String password;
  final String repassword;
  final String machineNumber;

  RegisterState copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? businessName,
    String? address,
    String? phone,
    String? email,
    String? password,
    String? repassword,
    String? machineNumber
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      businessName: businessName ?? this.businessName,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      repassword: repassword ?? this.repassword,
      machineNumber: machineNumber ?? this.machineNumber,
    );
  }
}
