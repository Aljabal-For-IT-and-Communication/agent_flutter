import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:app/common/values/constant.dart';
import 'package:app/global.dart';
import 'package:app/pages/home/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/values/colors.dart';
import 'logic.dart';

class BuildAppBar extends StatelessWidget {
  BuildAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProfile = context.read<HomeBloc>().state.userProfile;
    double indebtedness = double.parse(userProfile?.indebtedness ?? "0");
    double maxIndebtedness = double.parse(userProfile?.maxIndebtedness ?? "0");
    double? maxBalance = double.parse(userProfile?.maxBalance ?? "0");
    double? indebtedness1 = indebtedness / maxIndebtedness;
    if (indebtedness1.isNaN || indebtedness1.isInfinite) {
      indebtedness1 = 0;
    }
    print("indebtedness1------------");
    print(indebtedness1);
    double? balance = double.parse(userProfile?.balance ?? "0");
    double? balance1 = balance / maxBalance;
    if (balance1.isNaN || balance1.isInfinite) {
      balance1 = 0;
    }
    return Container(
      width: 375.w,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/icons/headbg2.png'),
          fit: BoxFit.fitWidth, // 完全填充
        ),
      ),
      padding: EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w, bottom: 0.h),
      child: Column(
        children: [
          SizedBox(
            height: 25.h,
          ),
          Container(
            width: 343.w,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: 0.h, bottom: 0.h, left: 0.w, right: 0.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.h)),
                        ),
                        child: userProfile == null
                            ? Image.asset('assets/icons/head.png')
                            : CachedNetworkImage(
                                imageUrl:
                                    "$SERVER_IMG_URL${userProfile.avatar}",
                                fit: BoxFit.fitWidth,
                                errorWidget: (context, url, error) => Image(
                                      image:
                                          AssetImage('assets/icons/head.png'),
                                    )),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 100.w,
                            child: Text(
                              "Hello there".tr(),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.primaryBackground,
                                fontWeight: FontWeight.normal,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                          Container(
                            width: 100.w,
                            margin: EdgeInsets.only(top: 5.w),
                            child: Text(
                              "${userProfile?.firstName}",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.primaryBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.Message);
                        },
                        child: Image.asset("assets/icons/notification1.png",
                            width: 18.w)),
                    SizedBox(
                      width: 15.h,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.Setting);
                        },
                        child: Image.asset("assets/icons/settings.png",
                            width: 20.w)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Balance".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryBackground,
                          fontWeight: FontWeight.normal,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      child: Text(
                        "${userProfile?.indebtedness ?? 0} LYD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryBackground,
                          fontWeight: FontWeight.normal,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 8.h,
                      width: 85.w,
                      child: LinearProgressIndicator(
                        backgroundColor: AppColors.primaryBackground,
                        color: AppColors.primaryGreen,
                        value: indebtedness1,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Indebtedness".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryBackground,
                          fontWeight: FontWeight.normal,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      child: Text(
                        "${(double.tryParse(userProfile?.balance?.toString() ?? "0") ?? 0) - (double.tryParse(userProfile?.indebtedness?.toString() ?? "0") ?? 0)} LYD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryBackground,
                          fontWeight: FontWeight.normal,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 8.h,
                      width: 85.w,
                      child: LinearProgressIndicator(
                        backgroundColor: AppColors.primaryBackground,
                        color: AppColors.primaryRed,
                        value: indebtedness1,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "ْCeiling".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryBackground,
                          fontWeight: FontWeight.normal,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      child: Text(
                        "${userProfile?.balance ?? 0} LYD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryBackground,
                          fontWeight: FontWeight.normal,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 8.h,
                      width: 85.w,
                      child: LinearProgressIndicator(
                        backgroundColor: AppColors.primaryBackground,
                        color: AppColors.primaryFirstElement,
                        value: balance1,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
        ],
      ),
    );
  }
}

class BuildListItem extends StatelessWidget {
  final ShippingOperationData item;
  const BuildListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(AppRoutes.MessageDetail,arguments: item);
      },
      child: Container(
        padding:
            EdgeInsets.only(top: 6.h, bottom: 12.h, left: 10.w, right: 10.w),
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
              child: Image.asset('assets/icons/money2.png'),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Container(
                //   width: 170.w,
                //   child: Text(
                //     "${item.businessName}",
                //     textAlign: TextAlign.start,
                //     maxLines: 1,
                //     overflow: TextOverflow.ellipsis,
                //     style: TextStyle(
                //       color: AppColors.primaryText,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 14.sp,
                //     ),
                //   ),
                // ),
                Container(
                  width: 170.w,
                  child: Text(
                    "${item.businessName}",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primarySecondaryElementText,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 170.w,
                  margin: EdgeInsets.only(top: 5.w),
                  child: Text(
                    "${item.phone}",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primarySecondaryElementText,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 170.w,
                  margin: EdgeInsets.only(top: 5.w),
                  child: Text(
                    "${timeFormated(item.createdAt)}",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primarySecondaryElementText,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    child: Text(
                      "${item.amount} LYD",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 100.w,
                    child: Text(
                      "${item.profit} LYD",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  )
                ]),
          ],
        ),
      ),
    );
  }
}

class MenuView extends StatelessWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.only(top: 0.h, bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.AccountStatement);
            },
            child: Container(
              width: 100.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryFourElementText, // 阴影颜色
                    spreadRadius: 1, // 阴影扩展半径
                    blurRadius: 10, // 模糊半径
                    offset: Offset(5, 5), // 右下方向的阴影偏移
                  ),
                  BoxShadow(
                    color: AppColors.primaryFourElementText,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(-5, -5), // 左上方向的阴影偏移
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 38.h,
                    child: Image.asset(
                      'assets/icons/book.png',
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    child: Text(
                      "account statement".tr(),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.primaryElement,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              var result = await Navigator.of(context)
                  .pushNamed(AppRoutes.TransferBalance);
              if (result == 'ok') {
                Logic(context: context).init();
              }
            },
            child: Container(
              width: 100.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryFourElementText, // 阴影颜色
                    spreadRadius: 1, // 阴影扩展半径
                    blurRadius: 10, // 模糊半径
                    offset: Offset(5, 5), // 右下方向的阴影偏移
                  ),
                  BoxShadow(
                    color: AppColors.primaryFourElementText,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(-5, -5), // 左上方向的阴影偏移
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 38.h,
                    child: Image.asset(
                      'assets/icons/icon-transfer.png',
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    child: Text(
                      "Transfer balance".tr(),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.primaryElement,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.Credit);
            },
            child: Container(
              width: 100.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryFourElementText, // 阴影颜色
                    spreadRadius: 1, // 阴影扩展半径
                    blurRadius: 10, // 模糊半径
                    offset: Offset(5, 5), // 右下方向的阴影偏移
                  ),
                  BoxShadow(
                    color: AppColors.primaryFourElementText,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(-5, -5), // 左上方向的阴影偏移
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 38.h,
                    child: Image.asset(
                      'assets/icons/top.png',
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    child: Text(
                      "Request credit".tr(),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.primaryElement,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
