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
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/icons/headbg.png'),
          fit: BoxFit.fill, // 完全填充
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryBackground,
                      size: 28.sp,
                    ),
                  ),
                ),
                Container(
                  width: 240.w,
                  child: Text(
                    "AccountStatement Communications",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                Container(
                  width: 40.w,
                  height: 40.w,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            child: Text(
              "Balance",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.normal,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            child: Text(
              "د.ل 5000.000",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.normal,
                fontSize: 18.sp,
              ),
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
  final String icon;
  final Color color;
  final String route;
  const BuildListItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, AppRoutes.Detail,arguments: item);
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(15.w)),
              ),
              padding: EdgeInsets.all(20.w),
              child: Image.asset(
                icon,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              child: Text(
                "${title}",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
