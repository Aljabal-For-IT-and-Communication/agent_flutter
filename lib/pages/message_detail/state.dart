part of 'bloc.dart';

class MessageDetailState {
  const MessageDetailState({
    this.detail,
  });
  final NotificationData? detail;

  MessageDetailState copyWith({
    NotificationData? detail,
  }) {
    return MessageDetailState(
      detail: detail ?? this.detail,
    );
  }
}
