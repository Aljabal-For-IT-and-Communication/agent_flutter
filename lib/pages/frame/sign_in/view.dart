import 'package:app/common/values/values.dart';
import 'package:app/pages/frame/sign_in/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/icons/headbg1.png'),
                  fit: BoxFit.fitWidth, // 完全填充
                ),
              ),
              child: CustomScrollView(slivers: [
                SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.w,
                      horizontal: 0.w,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: BuildAppBar(),
                    )),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 30.w,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Card(
                      color: AppColors.primaryBackground,
                      shadowColor: AppColors.primaryThreeElementText,
                      surfaceTintColor: AppColors.primaryBackground,
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 16.w, right: 16.w, top: 30.h, bottom: 20.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 280.w,
                              child: Text(
                                "Login".tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10.h, top: 0.h),
                              child: Text(
                                "phone number".tr(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            BuildEmailInput(),
                            Container(
                              margin: EdgeInsets.only(bottom: 10.h, top: 0.h),
                              child: Text(
                                "password".tr(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            BuildPasswordInput(),
                            SizedBox(
                              height: 0.h,
                            ),
                            ForgotPassword(),
                            BuildLoginBtn(),
                            SizedBox(
                              height: 5.h,
                            ),
                            //   BuildGuestBtn(),
                            SizedBox(
                              height: 10.h,
                            ),
                            //  BuildRegBtn(),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]));
        });
  }
}
