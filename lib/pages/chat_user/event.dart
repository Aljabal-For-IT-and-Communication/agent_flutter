part of 'bloc.dart';

abstract class ChatUserEvent {
  const ChatUserEvent();
}

class HeadDetailChanged extends ChatUserEvent {
  const HeadDetailChanged(this.headDetail);

  final UserItem headDetail;
}

class TabStatusChanged extends ChatUserEvent {
  const TabStatusChanged(this.tabStatus);

  final bool tabStatus;
}

class ChatListChanged extends ChatUserEvent {
  const ChatListChanged(this.chatList);

  final List<ChatUserItem> chatList;
}
