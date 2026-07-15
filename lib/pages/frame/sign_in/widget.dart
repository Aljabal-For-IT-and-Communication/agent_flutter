import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/values/colors.dart';
import 'package:app/global.dart';
import 'bloc.dart';
import 'logic.dart';

class BuildAppBar extends StatelessWidget {
  BuildAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 375.w,
      padding:
          EdgeInsets.only(top: 80.h, left: 16.w, right: 16.w, bottom: 10.h),
      child: Column(
        children: [
          Container(
            width: 130.w,
            alignment: Alignment.center,
            child: Image.asset("assets/icons/logo.png"),
          ),
        ],
      ),
    );
  }
}

class BuildLoginBtn extends StatelessWidget {
  BuildLoginBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child: Container(
            width: 343.w,
            height: 46.h,
            margin: EdgeInsets.only(top: 10.h, left: 0.w, right: 0.w),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
            ),
            child: Center(
                child: Text(
              "Login".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
            ))),
        onTap: () {
          Logic(context: context).asyncPostAllData();
        });
  }
}

class BuildLoginLanguageButton extends StatelessWidget {
  const BuildLoginLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Semantics(
      label: "Change Language".tr(),
      child: TextButton.icon(
        onPressed: () {
          final locale = isArabic ? const Locale('en') : const Locale('ar');
          context.setLocale(locale);
          Global.storageService.setLanguage(locale.languageCode);
        },
        icon: Icon(Icons.language_outlined, size: 18.sp),
        label: Text(
          isArabic ? 'English' : 'العربية',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryElement,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        ),
      ),
    );
  }
}

class BuildGuestBtn extends StatelessWidget {
  BuildGuestBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child: Container(
            width: 343.w,
            height: 46.h,
            margin: EdgeInsets.only(top: 10.h, left: 0.w, right: 0.w),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
            ),
            child: Center(
                child: Text(
              "Login as a guest".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
            ))),
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.Application, (Route<dynamic> route) => false);
        });
  }
}

class BuildRegBtn extends StatelessWidget {
  BuildRegBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child: Container(
            width: 343.w,
            height: 30.h,
            margin: EdgeInsets.only(top: 0.h, left: 0.w, right: 0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "I don't have an account before".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryElement,
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                )
              ],
            )),
        onTap: () {
          // Get.toNamed(AppRoutes.Register);
          Navigator.of(context).pushNamed(AppRoutes.Register);
        });
  }
}

class BuildEmailInput extends StatelessWidget {
  BuildEmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50.h,
      margin: EdgeInsets.only(bottom: 20.h, top: 0.h),
      padding: EdgeInsets.only(top: 0.h, bottom: 0.h),
      decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          border: Border.all(color: AppColors.primaryFourElementText)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.w),
            padding: EdgeInsets.only(left: 0.w, top: 0.w),
            width: 16.w,
            height: 16.w,
            child: Image.asset("assets/icons/user.png"),
          ),
          Container(
            width: 240.w,
            height: 46.h,
            child: TextField(
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "",
                contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
              ),
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Avenir",
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
              ),
              onChanged: (value) {
                context.read<SignInBloc>().add(PhoneChanged(value));
              },
              maxLines: 1,
              autocorrect: false, // 自动纠正
              obscureText: false, // 隐藏输入内容, 密码框
            ),
          )
        ],
      ),
    );
  }
}

class BuildPasswordInput extends StatelessWidget {
  BuildPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50.h,
      margin: EdgeInsets.only(bottom: 0.h, top: 0.h),
      padding: EdgeInsets.only(top: 0.h, bottom: 0.h),
      decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          border: Border.all(color: AppColors.primaryFourElementText)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.w),
            padding: EdgeInsets.only(left: 0.w, top: 0.w),
            width: 16.w,
            height: 16.w,
            child: Image.asset("assets/icons/lock.png"),
          ),
          Container(
            width: 240.w,
            height: 46.h,
            child: TextField(
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "",
                contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
              ),
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Avenir",
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
              ),
              onChanged: (value) {
                context.read<SignInBloc>().add(PasswordChanged(value));
              },
              maxLines: 1,
              autocorrect: false, // 自动纠正
              obscureText: false, // 隐藏输入内容, 密码框
            ),
          )
        ],
      ),
    );
  }
}
