import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class MessageDetailBloc extends Bloc<MessageDetailEvent, MessageDetailState> {
  MessageDetailBloc() : super(const MessageDetailState()) {
    on<MessageDetailChanged>(_onMessageDetailChanged);
  }
  void _onMessageDetailChanged(
      MessageDetailChanged event,
      Emitter<MessageDetailState> emit,
      ) {
    emit(state.copyWith(detail: event.detail));
  }
}
