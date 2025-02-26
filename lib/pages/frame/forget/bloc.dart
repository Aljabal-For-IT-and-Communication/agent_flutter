import 'package:bloc/bloc.dart';

part 'event.dart';
part 'state.dart';

class ForgetBloc extends Bloc<ForgetEvent, ForgetState> {
  ForgetBloc() : super(const ForgetState()) {
    on<PhoneChanged>(_onPhoneChanged);
    on<PasswordChanged>((_onPasswordChanged));
    on<VerificationCodeChanged>((_onVerificationCodeChanged));
    on<ConfirmPasswordChanged>((_onConfirmPasswordChanged));
    on<CountDownTimeChanged>((_onCountDownTimeChanged));
    on<IsSendChanged>((_onIsSendChanged));
  }

  void _onPhoneChanged(
      PhoneChanged event,
      Emitter<ForgetState> emit,
      ) {
    emit(state.copyWith(phone: event.phone));
  }
  void _onIsSendChanged(
      IsSendChanged event,
      Emitter<ForgetState> emit,
      ) {
    emit(state.copyWith(isSend: event.isSend));
  }
  void _onCountDownTimeChanged(
      CountDownTimeChanged event,
      Emitter<ForgetState> emit,
      ) {
    emit(state.copyWith(countDownTime: event.countDownTime));
  }

  void _onPasswordChanged(
      PasswordChanged event,
      Emitter<ForgetState> emit,
      ) {
    emit(state.copyWith(password: event.password));
  }

  void _onVerificationCodeChanged(
      VerificationCodeChanged event,
      Emitter<ForgetState> emit,
      ) {
    emit(state.copyWith(verificationCode: event.verificationCode));
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event,
      Emitter<ForgetState> emit,
      ) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

}
