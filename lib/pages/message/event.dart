part of 'bloc.dart';

abstract class MessageEvent {
  const MessageEvent();
}

class MessageChanged extends MessageEvent {
  const MessageChanged(this.message);

  final List<NotificationData> message;
}

class IsMoreChanged extends MessageEvent {
  const IsMoreChanged(this.isMore);

  final bool isMore;
}