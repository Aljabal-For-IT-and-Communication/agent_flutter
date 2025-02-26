part of 'bloc.dart';

abstract class MessageDetailEvent {
  const MessageDetailEvent();
}

class MessageDetailChanged extends MessageDetailEvent {
  const MessageDetailChanged(this.detail);

  final NotificationData detail;

}