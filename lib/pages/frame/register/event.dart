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

class BusinessNameChanged extends RegisterEvent {
  const BusinessNameChanged(this.businessName);
  final String businessName;
}

class PhoneChanged extends RegisterEvent {
  const PhoneChanged(this.phone);
  final String phone;
}

class AddressChanged extends RegisterEvent {
  const AddressChanged(this.address);
  final String address;
}

class AgentPhoneChanged extends RegisterEvent {
  const AgentPhoneChanged(this.agentPhone);
  final String agentPhone;
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

class AgentItemChanged extends RegisterEvent {
  const AgentItemChanged(this.agentItem);
  final AgentData? agentItem;
}

class MachineNumberChanged extends RegisterEvent {
  const MachineNumberChanged(this.machineNumber);
  final String machineNumber;
}
