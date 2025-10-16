import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/colors.dart';

class BuildAppBar extends StatelessWidget {
  BuildAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                    "My ShippingOperation".tr(),
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
                    "${item.businessName ?? item.firstName}",
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
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 100.w,
                    child: Text(
                      item.rechargeTypeName ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: AppColors.primaryFirstElementText,
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
                      item.collectTypeName ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: AppColors.primaryFirstElementText,
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
