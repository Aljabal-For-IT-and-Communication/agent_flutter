import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/apis/sale_point.dart';
import '../../common/entities/transfer.dart';
import '../../common/utils/logger.dart';
import '../../common/utils/security.dart';
import 'bloc.dart';
import 'widget.dart';
import 'logic.dart';

class CollectionItemPage extends StatefulWidget {
  const CollectionItemPage({Key? key}) : super(key: key);

  @override
  State<CollectionItemPage> createState() => _CollectionItemPageState();
}

class _CollectionItemPageState extends State<CollectionItemPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        Logic(context: context).init();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  postTransformation() async {
    final state = context.read<CollectionItemBloc>().state;
    String Amount = state.Amount;
    // String phone = state.phone;
    // if(phone.isEmpty){
    //   toastInfo(msg: "First Name not empty!");
    //   return;
    // }
    if (Amount.isEmpty) {
      toastInfo(msg: "Amount not empty!".tr());
      return;
    }

    if (state.agentItem == null && state.salePointItem == null) {
      toastInfo(msg: "Please select agent or sale point!".tr());
      return;
    }
    if (state.collectTypeId == null) {
      toastInfo(msg: "Please select collect type".tr());
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    TransferRequestEntity entity = TransferRequestEntity();

    entity.id =
        state.agent == "Agent" ? state.agentItem?.id : state.salePointItem?.id;
    entity.Category = state.agent;
    entity.Amount = state.Amount;
    entity.transferType = state.collectTypeId;
    try {
      var result = await SalePointAPI.transferCollection(params: entity);
      EasyLoading.dismiss();
      toastInfo(msg: "${result.msg}");
      if (result.code == 0) {
        context.read<CollectionItemBloc>().add(IsShowChanged(false));
        double amountOwed = 0;
        double amounts = double.parse(state.Amount);
        if (state.agent == "Agent") {
          double balance = double.parse(state.agentItem?.balance ?? "0");
          amountOwed = balance - amounts;
          if (amountOwed.isNaN || amountOwed.isInfinite) {
            amountOwed = 0;
          }
        } else {
          double balance = double.parse(state.salePointItem?.balance ?? "0");
          amountOwed = balance - amounts;
          if (amountOwed.isNaN || amountOwed.isInfinite) {
            amountOwed = 0;
          }
        }
        showDialog(
          context: context,
          builder: (contexts) {
            return AlertDialog(
              title: null,
              content: Container(
                height: 370.h,
                padding: EdgeInsets.only(
                    top: 20.h, left: 16.w, right: 16.w, bottom: 20.h),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Result".tr() + ":",
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
                        "Name".tr() +
                            ": ${state.agent == "Agent" ? state.agentItem?.firstName : state.salePointItem?.businessName}",
                        textAlign: TextAlign.center,
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
                        "Phone Number".tr() +
                            ": ${state.agent == "Agent" ? state.agentItem?.phone : state.salePointItem?.phone}",
                        textAlign: TextAlign.center,
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
                        "Amount owed".tr() + ": ${amountOwed}",
                        textAlign: TextAlign.center,
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
                        "Amount to be collected".tr() + ": ${state.Amount}",
                        textAlign: TextAlign.center,
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
                    GestureDetector(
                        child: Container(
                            height: 40.h,
                            width: 140.w,
                            margin: EdgeInsets.only(
                                top: 20.h, left: 0.w, right: 0.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryElement,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.w)),
                            ),
                            child: Center(
                                child: Text(
                              "PDF Print".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryBackground,
                                fontWeight: FontWeight.normal,
                                fontSize: 16.sp,
                              ),
                            ))),
                        onTap: () async {
                          await printPdf(result.data!,
                              businessName: state.agent == "Agent"
                                  ? ""
                                  : (state.salePointItem?.businessName ?? ""));
                          Navigator.pop(contexts);
                          Navigator.pop(context);
                        }),
                    GestureDetector(
                        child: Container(
                            height: 40.h,
                            width: 140.w,
                            margin: EdgeInsets.only(
                                top: 20.h, left: 0.w, right: 0.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryElement,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.w)),
                            ),
                            child: Center(
                                child: Text(
                              "Cancel".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryBackground,
                                fontWeight: FontWeight.normal,
                                fontSize: 16.sp,
                              ),
                            ))),
                        onTap: () {
                          Navigator.of(contexts).pop();
                        })
                  ],
                ),
              ),
            );
          },
        );
        Logic(context: context).init();
        //  Navigator.pop(context);
      }
    } catch (e) {
      EasyLoading.dismiss();
      toastInfo(msg: 'internet error');
      Logger.write("${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CollectionItemBloc, CollectionItemState>(
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
                  child: BuildPublicAppBar(title: "Collections".tr()),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildDropdownAgentInput(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: state.agent == "Agent"
                      ? BuildDropdownAgentNameInput()
                      : BuildDropdownSalePointNameInput(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildPhoneInput(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 20.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildBtn(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: state.isShow
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            Container(
                              child: Text(
                                "Result".tr() + ":",
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
                                "Name".tr() +
                                    ": ${state.agent == "Agent" ? state.agentItem?.firstName : state.salePointItem?.businessName}",
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
                                "Phone Number".tr() +
                                    ": ${state.agent == "Agent" ? state.agentItem?.phone : state.salePointItem?.phone}",
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
                                "Amount owed and to be collected".tr() +
                                    ": ${state.agent == "Agent" ? state.agentItem?.balance : state.salePointItem?.balance}",
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
                          ],
                        )
                      : Container(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildAmountInput(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildDropdownCollectTypeInput(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: GestureDetector(
                      child: Container(
                          height: 46.h,
                          width: 160.w,
                          margin:
                              EdgeInsets.only(top: 20.h, left: 0.w, right: 0.w),
                          decoration: BoxDecoration(
                            color: AppColors.primaryElement,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.w)),
                          ),
                          child: Center(
                              child: Text(
                            "collection".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryBackground,
                              fontWeight: FontWeight.normal,
                              fontSize: 16.sp,
                            ),
                          ))),
                      onTap: () async {
                        postTransformation();
                      }),
                )),
          ]));
    });
  }
}
