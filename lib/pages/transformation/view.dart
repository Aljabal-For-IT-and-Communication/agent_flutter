import 'package:app/common/widgets/form_scroll_view.dart';
import 'package:app/common/values/values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';

class TransformationPage extends StatefulWidget {
  const TransformationPage({Key? key}) : super(key: key);

  @override
  State<TransformationPage> createState() => _TransformationPageState();
}

class _TransformationPageState extends State<TransformationPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        //   Logic(context: context).init();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<TransformationBloc, TransformationState>(
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
                  child: BuildAppBar(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildInput(
                    name: "Type of converter".tr(),
                  ),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildInput(
                    name: "Transferred to".tr(),
                    textInputAction: TextInputAction.done,
                  ),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "Recipient".tr(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        child: Text(
                          "Name".tr(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        child: Text(
                          "Area Name".tr(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        child: Text(
                          "Amount to be transferred".tr() + ":",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 330.w,
                        child: Text(
                          "Are you sure about the conversion process?".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primarySecondaryElementText,
                            fontWeight: FontWeight.normal,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildBtn(),
                )),
          ]));
    });
  }
}
