import 'package:app/common/values/values.dart';
// import 'package:app/common/widgets/widgets.dart';
import 'package:app/global.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'bloc.dart';
import 'widget.dart';
import 'logic.dart';

class TransferBalancePage extends StatefulWidget {
  const TransferBalancePage({Key? key}) : super(key: key);

  @override
  State<TransferBalancePage> createState() => _TransferBalancePageState();
}

class _TransferBalancePageState extends State<TransferBalancePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        var userProfile = Global.storageService.getUserProfile();
        context.read<TransferBalanceBloc>().add(AmountChanged(""));
        context
            .read<TransferBalanceBloc>()
            .add(UserProfileChanged(userProfile));
        Logic(context: context).init();
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
    return BlocBuilder<TransferBalanceBloc, TransferBalanceState>(
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
                  child: BuildAppBar(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildDropdownTypeInput(),
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
                  child: state.agent == "SalePoint" && state.type == "recharge"
                      ? BuildDropdownRechargeTypeInput()
                      : Container(),
                )),
            // SliverPadding(
            //     padding: EdgeInsets.symmetric(
            //       vertical: 0.h,
            //       horizontal: 16.w,
            //     ),
            //     sliver: SliverToBoxAdapter(
            //       child: BuildPhoneInput(),
            //     )),
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
                          "Type of converter".tr() + ": ${state.type}",
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
                          "Amount to be transferred".tr() + ": ${state.Amount}",
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
