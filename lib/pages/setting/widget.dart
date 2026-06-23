import 'package:app/common/values/values.dart';
import 'package:app/global.dart';
import 'package:app/pages/setting/bloc.dart';
import 'package:app/pages/setting/event.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildListItem extends StatelessWidget {
  final String title;
  final String iconImage;
  final Color? iconColor;
  final Function()? callFunc;
  const BuildListItem({
    Key? key,
    required this.title,
    required this.iconImage,
    this.iconColor,
    required this.callFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 24.h,
              height: 24.h,
              child: Image.asset(iconImage, color: iconColor),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.w),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: callFunc,
    );
  }
}

class BuildLanguage extends StatelessWidget {
  const BuildLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<SettingBloc>().state;
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 24.h,
                height: 24.h,
                child: Image.asset("assets/icons/rechange.png"),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w),
                child: Text(
                  "Change Language".tr(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 24.h,
            height: 24.h,
            child: Switch(
              value: state.language,
              activeColor: AppColors.primaryElement,
              onChanged: (bool value) {
                // 切换语言
                if (context.locale == Locale('en')) {
                  context.setLocale(Locale('ar')); // 切换到阿拉伯语
                  Global.storageService.setLanguage('ar');
                  context.read<SettingBloc>().add(IsLanguageChanged(true));
                } else {
                  context.setLocale(Locale('en')); // 切换到英语
                  Global.storageService.setLanguage('en');
                  context.read<SettingBloc>().add(IsLanguageChanged(false));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
