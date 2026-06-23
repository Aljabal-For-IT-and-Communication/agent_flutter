import 'package:app/common/entities/entities.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/utils/utils.dart';

import 'bloc.dart';
import 'logic.dart';

class AccountStatementPage extends StatefulWidget {
  const AccountStatementPage({Key? key}) : super(key: key);

  @override
  State<AccountStatementPage> createState() => _AccountStatementPageState();
}

class _AccountStatementPageState extends State<AccountStatementPage> {
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AccountStatementBloc, AccountStatementState>(
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
                  child: BuildPublicAppBar(title: "Account Statement".tr()),
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
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        child: Text(
                          "Money owed to you by POS".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        child: Text(
                          "Currently".tr() +
                              ": ${state.accountStatement?.moneyOwedYou ?? 0}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.normal,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  final fmt = DateFormat('yyyy-MM-dd HH:mm:ss');
                                  final initial = (state.startDate != null &&
                                          state.startDate!.isNotEmpty)
                                      ? (() {
                                          try {
                                            return fmt.parse(state.startDate!);
                                          } catch (_) {
                                            return DateTime.now();
                                          }
                                        })()
                                      : DateTime.now();
                                  DatePicker.showDateTimePicker(
                                    context,
                                    showTitleActions: true,
                                    onChanged: (date) {},
                                    onConfirm: (date) {
                                      final formatted =
                                          DateFormat('yyyy-MM-dd HH:mm:ss')
                                              .format(date);
                                      context
                                          .read<AccountStatementBloc>()
                                          .add(StartDateChanged(formatted));
                                    },
                                    onCancel: () {
                                      context
                                          .read<AccountStatementBloc>()
                                          .add(StartDateChanged(""));
                                    },
                                    currentTime: initial,
                                    locale: pickerLocaleFrom(context),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.w)),
                                  ),
                                  child: Text(
                                    "Select date from".tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.primaryBackground,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                child: Text(
                                  replaceArabicNumbers(state.startDate ?? ""),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        AppColors.primarySecondaryElementText,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  final fmt = DateFormat('yyyy-MM-dd HH:mm:ss');
                                  final initial = (state.endDate != null &&
                                          state.endDate!.isNotEmpty)
                                      ? (() {
                                          try {
                                            return fmt.parse(state.endDate!);
                                          } catch (_) {
                                            return DateTime.now();
                                          }
                                        })()
                                      : DateTime.now();
                                  DatePicker.showDateTimePicker(
                                    context,
                                    showTitleActions: true,
                                    onChanged: (date) {},
                                    onConfirm: (date) {
                                      final formatted =
                                          DateFormat('yyyy-MM-dd HH:mm:ss')
                                              .format(date);
                                      context
                                          .read<AccountStatementBloc>()
                                          .add(EndDateChanged(formatted));
                                    },
                                    onCancel: () {
                                      context
                                          .read<AccountStatementBloc>()
                                          .add(EndDateChanged(""));
                                    },
                                    currentTime: initial,
                                    locale: pickerLocaleFrom(context),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.w)),
                                  ),
                                  child: Text(
                                    "Select date to".tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.primaryBackground,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                child: Text(
                                  replaceArabicNumbers(state.endDate ?? ""),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        AppColors.primarySecondaryElementText,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (state.startDate == "") {
                            toastInfo(msg: "please select date from".tr());
                            return;
                          }
                          if (state.endDate == "") {
                            toastInfo(msg: "please select date to".tr());
                            return;
                          }
                          final fmt = DateFormat('yyyy-MM-dd HH:mm:ss');
                          DateTime date1 = fmt.parse(state.startDate!);
                          DateTime date2 = fmt.parse(state.endDate!);
                          if (date1.isAfter(date2)) {
                            toastInfo(msg: "date from not After date to!".tr());
                            return;
                          }

                          DateRangeRequestEntity entity =
                              DateRangeRequestEntity();
                          entity.startDate =
                              replaceArabicNumbers(state.startDate ?? "");
                          entity.endDate =
                              replaceArabicNumbers(state.endDate ?? "");
                          Logic(context: context).accountStatement(entity);
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
                  vertical: 10.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: Table(
                    border: TableBorder.all(color: Colors.black), // 表格边框
                    columnWidths: const {
                      0: FlexColumnWidth(3), // 第一列宽度
                      1: FlexColumnWidth(3), // 第二列宽度
                    },
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('name'.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('data'.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Current Balance'.tr()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${state.accountStatement?.currentBalance ?? 0}'),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Paid money'.tr()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${state.accountStatement?.paidMoney ?? 0}'),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Sent balance'.tr()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${state.accountStatement?.sendBalance ?? 0}'),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Money you owe'.tr()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${state.accountStatement?.moneyYouOwe ?? 0}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ]));
    });
  }
}
