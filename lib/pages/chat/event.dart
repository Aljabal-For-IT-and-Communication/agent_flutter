part of 'bloc.dart';

abstract class ChatEvent {
  const ChatEvent();

  List<Object> get props => [];
}

class ProfileChanged extends ChatEvent {
  const ProfileChanged(this.chatUserItem);

  final ChatUserItem? chatUserItem;
}

class MsgContentListChanged extends ChatEvent {
  const MsgContentListChanged(this.msgContentList);

  final Message msgContentList;
}

class MsgContentAdd extends ChatEvent {
  const MsgContentAdd(this.msgContent);

  final Message msgContent;
}

class MsgContentClear extends ChatEvent {
  const MsgContentClear();
}

class isloadingChanged extends ChatEvent {
  const isloadingChanged(this.isloading);

  final bool isloading;
}

class moreStatusChanged extends ChatEvent {
  const moreStatusChanged(this.more_status);

  final bool more_status;
}
