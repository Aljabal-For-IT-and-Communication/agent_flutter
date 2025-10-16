import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
      return Container(
          color: AppColors.primaryBackground,
          child: CustomScrollView(slivers: [
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.w,
                  horizontal: 0.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildPublicAppBar(title: "change password".tr()),
                )),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 15.h,
                horizontal: 16.w,
              ),
              sliver: SliverToBoxAdapter(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      BuildInput(
                          name: 'Current Password'.tr(),
                          callFunc: (value) {
                            context
                                .read<ChangePasswordBloc>()
                                .add(PasswordChanged(value));
                          }),
                      BuildInput(
                          name: 'New Password'.tr(),
                          callFunc: (value) {
                            context
                                .read<ChangePasswordBloc>()
                                .add(RePasswordChanged(value));
                          }),
                      BuildInput(
                          name: 'Confirm Password'.tr(),
                          callFunc: (value) {
                            context
                                .read<ChangePasswordBloc>()
                                .add(ConfirmPasswordChanged(value));
                          }),
                      SizedBox(
                        height: 0.h,
                      ),
                      BuildBtn(),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Text(
                          "If you forgot your current password, please contact the administration on the following numbers: 0919491111"
                              .tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primarySecondaryElementText,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]));
    });
  }
}
