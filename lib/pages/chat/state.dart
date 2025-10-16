part of 'bloc.dart';

class ChatState {
  const ChatState({
    this.chatUserItem,
    this.isloading = false,
    this.more_status = false,
    this.msgcontentList = const <Message>[],
  });

  final ChatUserItem? chatUserItem;
  final bool isloading;
  final bool more_status;
  final List<Message> msgcontentList;

  ChatState copyWith({
    ChatUserItem? chatUserItem,
    bool? isloading,
    bool? more_status,
    List<Message>? msgcontentList,
  }) {
    return ChatState(
      chatUserItem: chatUserItem ?? this.chatUserItem,
      isloading: isloading ?? this.isloading,
      more_status: more_status ?? this.more_status,
      msgcontentList: msgcontentList ?? this.msgcontentList,
    );
  }
}
