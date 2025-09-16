import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:app/pages/frame/register/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return Scaffold(
        body: Container(
          color: AppColors.primaryBackground,
          child: CustomScrollView(slivers: [
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.w,
                  horizontal: 0.w,
                ),
                sliver: SliverToBoxAdapter(
                  child:
                      BuildPublicAppBar(title: "Register new sale point".tr()),
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
                          name: "First Name".tr(),
                          callFunc: (value) {
                            context
                                .read<RegisterBloc>()
                                .add(FirstNameChanged(value));
                          }),
                      BuildInput(
                          name: "Middle Name".tr(),
                          callFunc: (value) {
                            context
                                .read<RegisterBloc>()
                                .add(MiddleNameChanged(value));
                          }),
                      BuildInput(
                          name: "Last Name".tr(),
                          callFunc: (value) {
                            context
                                .read<RegisterBloc>()
                                .add(LastNameChanged(value));
                          }),
                      BuildInput(
                          name: "Business Name".tr(),
                          callFunc: (value) {
                            context
                                .read<RegisterBloc>()
                                .add(BusinessNameChanged(value));
                          }),
                      BuildInput(
                          name: "Address".tr(),
                          callFunc: (value) {
                            context
                                .read<RegisterBloc>()
                                .add(AddressChanged(value));
                          }),
                      BuildInput(
                          name: "Email(optional)".tr(),
                          callFunc: (value) {
                            context
                                .read<RegisterBloc>()
                                .add(EmailChanged(value));
                          }),
                      BuildInput(
                          name: "Phone Number".tr(),
                          callFunc: (value) {
                            context
                                .read<RegisterBloc>()
                                .add(PhoneChanged(value));
                          }),
                      BuildInput(
                          name: "password".tr(),
                          callFunc: (value) {
                            context
                                .read<RegisterBloc>()
                                .add(PasswordChanged(value));
                          }),
                      BuildInput(
                          name: "Confirm Password".tr(),
                          callFunc: (value) {
                            context
                                .read<RegisterBloc>()
                                .add(RePasswordChanged(value));
                          }),
                      const BuildMachineNumberInput(),
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
        ),
      );
    });
  }
}
