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
                    "Report".tr(),
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
  final String title;
  final String iconImage;
  final Function()? callFunc;
  const BuildListItem(
      {Key? key,
      required this.title,
      required this.iconImage,
      required this.callFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: callFunc,
      child: Container(
        padding:
            EdgeInsets.only(top: 12.h, bottom: 12.h, left: 10.w, right: 10.w),
        margin: EdgeInsets.only(bottom: 15.h),
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
                color: AppColors.primaryFourElementText,
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
              ),
              child: Image.asset(iconImage),
            ),
            SizedBox(
              width: 10.w,
            ),
            Container(
              width: 260.w,
              child: Text(
                title,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.normal,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
