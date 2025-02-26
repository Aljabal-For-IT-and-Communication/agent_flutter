part of 'bloc.dart';

class ChatUserState {
  const ChatUserState({
    this.tabStatus = true,
    this.headDetail,
    this.chatList = const <ChatUserItem>[],
  });

  final bool tabStatus;
  final UserItem? headDetail;
  final List<ChatUserItem> chatList;

  ChatUserState copyWith({
    bool? tabStatus,
    UserItem? headDetail,
    List<ChatUserItem>? chatList,
  }) {
    return ChatUserState(
      tabStatus: tabStatus ?? this.tabStatus,
      headDetail: headDetail ?? this.headDetail,
      chatList: chatList ?? this.chatList,
    );
  }
}
