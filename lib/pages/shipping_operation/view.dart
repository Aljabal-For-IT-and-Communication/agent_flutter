import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/routes.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';
import 'logic.dart';

class ShippingOperationPage extends StatefulWidget {
  const ShippingOperationPage({Key? key}) : super(key: key);

  @override
  State<ShippingOperationPage> createState() => _ShippingOperationPageState();
}

class _ShippingOperationPageState extends State<ShippingOperationPage> {
  ScrollController scrollController = ScrollController();
  var lastPostCalled;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        context.read<ShippingOperationBloc>().add(ShippingOperationChanged([]));
        context.read<ShippingOperationBloc>().add(DayChanged(""));
        context.read<ShippingOperationBloc>().add(IsMoreChanged(false));
        EasyLoading.show(
            indicator: CircularProgressIndicator(),
            maskType: EasyLoadingMaskType.clear,
            dismissOnTap: true);
        Logic(context: context).shippingOperation("",0);
      }
    });
    scrollController.addListener(() {
      if ((scrollController.offset + 10) > scrollController.position.maxScrollExtent) {
        if (lastPostCalled == null || DateTime.now().difference(lastPostCalled!) > Duration(seconds: 2)) {
          setState(() {
            lastPostCalled = DateTime.now();
          });
          context.read<ShippingOperationBloc>().add(IsMoreChanged(true));
          final state = context.read<ShippingOperationBloc>().state;
          Logic(context: context).shippingOperation(state.day,state.shippingOperationList.length);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingOperationBloc, ShippingOperationState>(builder: (context, state) {
      return Container(
          color: AppColors.primaryBackground,
          child: CustomScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.w,
                  horizontal: 0.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildPublicAppBar(title: "Shipping operations".tr(),),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "Select Today's Date".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true, onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                print('confirm $date');
                                String month = "${date.month}";
                                String day = "${date.day}";
                                if(date.month<10) {
                                  month = "0${date.month}";
                                 }
                                if(date.day<10) {
                                  day = "0${date.day}";
                                }
                                String days = "${date.year}-$month-$day";

                                context.read<ShippingOperationBloc>().add(DayChanged(days));
                              }, onCancel: () {
                                context.read<ShippingOperationBloc>().add(DayChanged(""));
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: Container(
                              width: 150.w,
                              height: 46.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2,
                                          color: AppColors.primaryElement))),
                              child: Text(
                                "${state.day}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.primaryElement,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 0.w, top: 0.w),
                            child: Text(
                              "day".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primarySecondaryElementText,
                                fontWeight: FontWeight.normal,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<ShippingOperationBloc>().add(ShippingOperationChanged([]));
                          EasyLoading.show(
                              indicator: CircularProgressIndicator(),
                              maskType: EasyLoadingMaskType.clear,
                              dismissOnTap: true);
                          Logic(context: context).shippingOperation(state.day,0);
                        },
                        child: Container(
                          width: 160.w,
                          height: 46.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primaryElement,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.w)),
                          ),
                          child: Text(
                            "Search".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryBackground,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
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
                  vertical: 0.w,
                  horizontal: 16.w,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      ShippingOperationData item =state.shippingOperationList.elementAt(index);
                      return BuildListItem(item: item);
                    },
                    childCount: state.shippingOperationList.length,
                  ),
                )),
            buildBottomLoading(state.isMore),
          ]));
    });
  }
}
