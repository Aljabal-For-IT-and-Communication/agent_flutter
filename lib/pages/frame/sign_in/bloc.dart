import 'package:bloc/bloc.dart';

part 'event.dart';
part 'state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<PhoneChanged>(_onPhoneChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<CheckChanged>(_onCheckChanged);
  }

  void _onPhoneChanged(
      PhoneChanged event,
      Emitter<SignInState> emit,
      ) {
    emit(state.copyWith(phone: event.phone));
  }
  void _onPasswordChanged(
      PasswordChanged event,
      Emitter<SignInState> emit,
      ) {
    emit(state.copyWith(password: event.password));
  }
  void _onCheckChanged(
      CheckChanged event,
      Emitter<SignInState> emit,
      ) {
    emit(state.copyWith(isChecked: event.isChecked));
  }
}
