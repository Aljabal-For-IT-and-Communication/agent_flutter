import 'package:app/common/entities/entities.dart';
import 'package:bloc/bloc.dart';

part 'event.dart';
part 'state.dart';

class ChatUserBloc extends Bloc<ChatUserEvent, ChatUserState> {
  ChatUserBloc() : super(const ChatUserState()) {
    on<HeadDetailChanged>(_onHeadDetailChanged);
    on<TabStatusChanged>(_onTabStatusChanged);
    on<ChatListChanged>(_onChatListChanged);
  }

  void _onHeadDetailChanged(
    HeadDetailChanged event,
    Emitter<ChatUserState> emit,
  ) {
    emit(state.copyWith(headDetail: event.headDetail));
  }

  void _onTabStatusChanged(
    TabStatusChanged event,
    Emitter<ChatUserState> emit,
  ) {
    emit(state.copyWith(tabStatus: event.tabStatus));
  }

  void _onChatListChanged(
    ChatListChanged event,
    Emitter<ChatUserState> emit,
  ) {
    emit(state.copyWith(chatList: event.chatList));
  }
}
