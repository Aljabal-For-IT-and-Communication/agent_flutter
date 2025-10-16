import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(new SettingState()) {
    on<IsOpenChanged>(_onIsOpenChanged);
    on<IsLanguageChanged>(_onIsLanguageChanged);
  }
  void _onIsOpenChanged(
    IsOpenChanged event,
    Emitter<SettingState> emit,
  ) {
    emit(state.copyWith(isOpen: event.isOpen));
  }

  void _onIsLanguageChanged(
    IsLanguageChanged event,
    Emitter<SettingState> emit,
  ) {
    emit(state.copyWith(language: event.language));
  }
}
