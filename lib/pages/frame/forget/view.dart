import 'package:app/pages/frame/forget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/colors.dart';
import 'bloc.dart';

class ForgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetBloc, ForgetState>(builder: (context, state) {
      return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/icons/headbg1.png'),
              fit: BoxFit.fill, // 完全填充
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
                            "Recover password".tr(),
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
                        BuildInput(
                            name: "phone number".tr(),
                            icon: "assets/icons/user.png",
                            callFunc: (value) {
                              context
                                  .read<ForgetBloc>()
                                  .add(PhoneChanged(value));
                            }),
                        BuildVerificationInput(),
                        BuildInput(
                            name: "password".tr(),
                            icon: "assets/icons/lock.png",
                            callFunc: (value) {
                              context
                                  .read<ForgetBloc>()
                                  .add(PasswordChanged(value));
                            }),
                        BuildInput(
                            name: "confirm password".tr(),
                            icon: "assets/icons/lock.png",
                            callFunc: (value) {
                              context
                                  .read<ForgetBloc>()
                                  .add(ConfirmPasswordChanged(value));
                            }),
                        BuildLoginBtn(),
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
