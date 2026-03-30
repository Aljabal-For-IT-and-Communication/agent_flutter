import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/utils/date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/colors.dart';
import 'package:app/pages/sale_point/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget outlinedText(
  String text, {
  required Color fillColor,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.bold,
  Color strokeColor = Colors.black,
  double strokeWidth = 0.3,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Stack(
    children: [
      Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..color = strokeColor,
        ),
      ),
      Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          color: fillColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    ],
  );
}

class BuildAppBar extends StatelessWidget {
  BuildAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      padding:
          EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w, bottom: 30.h),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/icons/headbg3.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 25.h,
          ),
          Container(
            width: 343.w,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 260.w,
                  child: Text(
                    "Points of sale".tr(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

class BuildListItem extends StatelessWidget {
  final SalePointData item;
  const BuildListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final balance = double.tryParse(item.balance ?? "0") ?? 0;

    return GestureDetector(
      onTap: () async {
        final deleted = await Navigator.of(context).pushNamed(
          AppRoutes.SalePointDetail,
          arguments: item,
        );
        if (deleted == true && context.mounted) {
          context.read<SalePointBloc>().add(SalePointRemoved(item.id));
        }
      },
      child: Container(
        padding:
            EdgeInsets.only(top: 12.h, bottom: 12.h, left: 10.w, right: 10.w),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: AppColors.primaryFourElementText,
          border:
              Border.all(color: AppColors.primaryThreeElementText, width: 1.h),
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.all(8.w),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.all(Radius.circular(20.w)),
              ),
              child: Image.asset('assets/icons/store.png'),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  outlinedText(
                    "${item.businessName}",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fillColor: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.w),
                    child: outlinedText(
                      "${item.firstName}",
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fillColor: AppColors.primarySecondaryElementText,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.w),
                    child: outlinedText(
                      "${item.phone}",
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fillColor: AppColors.primarySecondaryElementText,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                    ),
                  ),
                  if ((item.lastLogin ?? '').isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 5.w),
                      child: outlinedText(
                        "${'Last activity'.tr()}: ${timeFormated(item.lastLogin)}",
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fillColor: AppColors.primarySecondaryElementText,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.sp,
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        outlinedText(
                          "${"Balance".tr()} : ${item.indebtedness ?? 0} LYD",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fillColor: balance <= 300
                              ? AppColors.primaryRed
                              : AppColors.primarySuccess,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                        SizedBox(width: 10.h),
                        outlinedText(
                          "${"Indebtedness".tr()} : ${item.balance ?? 0} LYD",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fillColor: balance >= 1000
                              ? AppColors.primaryRed
                              : AppColors.primarySuccess,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.primarySecondaryElementText),
          ],
        ),
      ),
    );
  }
}

class BuildAgentListItem extends StatelessWidget {
  final AgentData item;
  const BuildAgentListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var balance = double.parse(item.indebtedness ?? "0");
    var realDebt = double.parse(item.realDebt ?? "0");
    var pendingRevenue = double.parse(item.pendingRevenue ?? "0");
    var agentDebt = double.parse(item.agentDebt ?? "0");
    var salePointsDebt = double.parse(item.salePointsDebt ?? "0");

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding:
            EdgeInsets.only(top: 12.h, bottom: 12.h, left: 10.w, right: 10.w),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: AppColors.primaryFourElementText,
          border:
              Border.all(color: AppColors.primaryThreeElementText, width: 1.h),
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.all(8.w),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.all(Radius.circular(20.w)),
              ),
              child: Image.asset('assets/icons/store.png'),
            ),
            SizedBox(
              width: 10.w,
            ),
            Container(
              width: 270.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 180.w,
                        margin: EdgeInsets.only(top: 5.w),
                        child: outlinedText(
                          "${item.firstName} ${item.middleName} ${item.lastName}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fillColor: AppColors.primaryText,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ),
                      Container(
                        width: 180.w,
                        margin: EdgeInsets.only(top: 5.w),
                        child: outlinedText(
                          "${item.phone}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fillColor: AppColors.primaryText,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            outlinedText(
                              "${"Balance".tr()} : ${item.indebtedness ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: balance <= 300
                                  ? AppColors.primaryRed
                                  : AppColors.primarySuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 10.h),
                            outlinedText(
                              "${"Agents Debt".tr()} : ${item.subAgentsDebt ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: agentDebt < 0
                                  ? AppColors.primaryRed
                                  : AppColors.primarySuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 10.h),
                            outlinedText(
                              "${"Sale Points Debt".tr()} : ${item.salePointsDebt ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: salePointsDebt < 0
                                  ? AppColors.primaryRed
                                  : AppColors.primarySuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 10.h),
                            outlinedText(
                              "${"Pending Revenue".tr()} : ${item.pendingRevenue ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: pendingRevenue < 0
                                  ? AppColors.primaryRed
                                  : AppColors.primarySuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 10.h),
                            outlinedText(
                              "${"Indebtedness".tr()} : ${item.realDebt ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: realDebt < 0
                                  ? AppColors.primaryRed
                                  : AppColors.primarySuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 10.h),
                            outlinedText(
                              "${"Ceiling".tr()} : ${item.balance ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: AppColors.primaryElement,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
