part of 'bloc.dart';

class MessageState {
  const MessageState({
    this.message = const <NotificationData>[],
    this.isMore = false,
  });

  final List<NotificationData> message;
  final bool isMore;

  MessageState copyWith({
    List<NotificationData>? message,
    bool? isMore,
  }) {
    return MessageState(
      message: message ?? this.message,
      isMore:isMore??this.isMore,
    );
  }
}
