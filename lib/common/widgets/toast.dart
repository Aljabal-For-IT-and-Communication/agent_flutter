import 'package:app/common/widgets/app_notification.dart';
import 'package:flutter/material.dart';

export 'app_notification.dart';

Future<void> toastInfo({
  required String msg,
  AppNotificationType type = AppNotificationType.info,
  Duration? duration,
  Color? backgroundColor,
  Color? textColor,
}) {
  AppNotification.show(
    message: msg,
    type: type,
    duration: duration,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
  return Future<void>.value();
}
