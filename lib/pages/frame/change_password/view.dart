import 'package:app/common/widgets/form_scroll_view.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordFocus = FocusNode();
  final _newPasswordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  @override
  void dispose() {
    _currentPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.primaryBackground,
          body: FormScrollView(slivers: [
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
                          focusNode: _currentPasswordFocus,
                          onEditingComplete: _newPasswordFocus.requestFocus,
                          callFunc: (value) {
                            context
                                .read<ChangePasswordBloc>()
                                .add(PasswordChanged(value));
                          }),
                      BuildInput(
                          name: 'New Password'.tr(),
                          focusNode: _newPasswordFocus,
                          onEditingComplete: _confirmPasswordFocus.requestFocus,
                          callFunc: (value) {
                            context
                                .read<ChangePasswordBloc>()
                                .add(RePasswordChanged(value));
                          }),
                      BuildInput(
                          name: 'Confirm Password'.tr(),
                          focusNode: _confirmPasswordFocus,
                          onEditingComplete: _confirmPasswordFocus.unfocus,
                          textInputAction: TextInputAction.done,
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
