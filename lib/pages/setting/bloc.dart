import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(new SettingState()) {
    on<IsLanguageChanged>(_onIsLanguageChanged);
  }

  void _onIsLanguageChanged(
    IsLanguageChanged event,
    Emitter<SettingState> emit,
  ) {
    emit(state.copyWith(language: event.language));
  }
}
