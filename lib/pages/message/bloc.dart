import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(const MessageState()) {
    on<MessageChanged>(_onMessageChanged);
    on<IsMoreChanged>(_onIsMoreChanged);

  }

  void _onMessageChanged(
      MessageChanged event,
      Emitter<MessageState> emit,
      ) {
    emit(state.copyWith(message: event.message));
  }

  void _onIsMoreChanged(
      IsMoreChanged event,
      Emitter<MessageState> emit,
      ) {
    emit(state.copyWith(isMore: event.isMore));
  }

}
