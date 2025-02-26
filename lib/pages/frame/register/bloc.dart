import 'package:bloc/bloc.dart';

part 'event.dart';
part 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<FirstNameChanged>((_onFirstNameChanged));
    on<MiddleNameChanged>((_onMiddleNameChanged));
    on<LastNameChanged>((_onLastNameChanged));
    on<PhoneChanged>((_onPhoneChanged));
    on<CityChanged>((_onCityChanged));
    on<AreaChanged>((_onAreaChanged));
    on<EmailChanged>((_onEmailChanged));
    on<PasswordChanged>((_onPasswordChanged));
    on<RePasswordChanged>((_onRePasswordChanged));
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

  void _onPhoneChanged(
      PhoneChanged event,
      Emitter<RegisterState> emit,
      ) {
    emit(state.copyWith(phone: event.phone));
  }


  void _onCityChanged(
      CityChanged event,
      Emitter<RegisterState> emit,
      ) {
    emit(state.copyWith(city: event.city));
  }


  void _onAreaChanged(
      AreaChanged event,
      Emitter<RegisterState> emit,
      ) {
    emit(state.copyWith(area: event.area));
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
}
