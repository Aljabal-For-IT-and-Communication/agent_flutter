import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> toastInfo({
  required String msg,
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
}) {
  EasyLoading.instance
    ..backgroundColor = backgroundColor
    ..textColor = textColor
    ..fontSize = 16.sp;

  return EasyLoading.showToast(
    msg,
    duration: const Duration(seconds: 2),
    toastPosition: EasyLoadingToastPosition.top,
  );
}
