import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:app/pages/frame/register/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return Container(
        color: AppColors.primaryBackground,
        child: CustomScrollView(slivers: [
          SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 0.w,
                horizontal: 0.w,
              ),
              sliver: SliverToBoxAdapter(
                child: BuildPublicAppBar(title: "Submit an application".tr()),
              )),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 0.h,
              horizontal: 16.w,
            ),
            sliver: SliverToBoxAdapter(
              child: Container(
                color: AppColors.primaryBackground,
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, top: 20.h, bottom: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildInput(
                        name: "first name".tr(),
                        callFunc: (value) {
                          context
                              .read<RegisterBloc>()
                              .add(FirstNameChanged(value));
                        }),
                    BuildInput(
                        name: "middle name".tr(),
                        callFunc: (value) {
                          context
                              .read<RegisterBloc>()
                              .add(MiddleNameChanged(value));
                        }),
                    BuildInput(
                        name: "last name".tr(),
                        callFunc: (value) {
                          context
                              .read<RegisterBloc>()
                              .add(LastNameChanged(value));
                        }),
                    BuildInput(
                        name: "city".tr(),
                        callFunc: (value) {
                          context.read<RegisterBloc>().add(CityChanged(value));
                        }),
                    BuildInput(
                        name: "area".tr(),
                        callFunc: (value) {
                          context.read<RegisterBloc>().add(AreaChanged(value));
                        }),
                    BuildInput(
                        name: "email(optional)".tr(),
                        callFunc: (value) {
                          context.read<RegisterBloc>().add(EmailChanged(value));
                        }),
                    BuildInput(
                        name: "phone number".tr(),
                        callFunc: (value) {
                          context.read<RegisterBloc>().add(PhoneChanged(value));
                        }),
                    BuildInput(
                        name: "password".tr(),
                        callFunc: (value) {
                          context
                              .read<RegisterBloc>()
                              .add(PasswordChanged(value));
                        }),
                    BuildInput(
                        name: "confirm password".tr(),
                        callFunc: (value) {
                          context
                              .read<RegisterBloc>()
                              .add(RePasswordChanged(value));
                        }),
                    BuildPresentationBtn(),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      );
    });
  }
}
