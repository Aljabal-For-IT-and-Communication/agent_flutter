import 'package:app/common/entities/entities.dart';
import 'package:bloc/bloc.dart';

part 'event.dart';
part 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<FirstNameChanged>((_onFirstNameChanged));
    on<MiddleNameChanged>((_onMiddleNameChanged));
    on<LastNameChanged>((_onLastNameChanged));
    on<BusinessNameChanged>((_onBusinessNameChanged));
    on<PhoneChanged>((_onPhoneChanged));
    on<AddressChanged>((_onAddressChanged));
    on<EmailChanged>((_onEmailChanged));
    on<PasswordChanged>((_onPasswordChanged));
    on<RePasswordChanged>((_onRePasswordChanged));
    on<MachineNumberChanged>((_onMachineNumberChanged));
  }

  void _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(firstName: event.firstName));
  }

  void _onMiddleNameChanged(
    MiddleNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(middleName: event.middleName));
  }

  void _onLastNameChanged(
    LastNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(lastName: event.lastName));
  }

  void _onBusinessNameChanged(
    BusinessNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(businessName: event.businessName));
  }

  void _onPhoneChanged(
    PhoneChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onAddressChanged(
    AddressChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(address: event.address));
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _onRePasswordChanged(
    RePasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(repassword: event.repassword));
  }
  void _onMachineNumberChanged(
    MachineNumberChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(machineNumber: event.machineNumber));
  }
}
