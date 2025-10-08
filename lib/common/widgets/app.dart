import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/values.dart';

///  AppBar
AppBar buildAppBar(String title) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    title: Container(
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
    ),
  );
}

/// 10像素 Divider
Widget divider10Px({Color bgColor = AppColors.primaryThreeElementText}) {
  return Container(
    height: 10.w,
    decoration: BoxDecoration(
      color: bgColor,
    ),
  );
}

class BuildPublicAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  BuildPublicAppBar({Key? key, required this.title, this.onBack})
      : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (onBack != null) {
                      onBack!();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryBackground,
                    ),
                  ),
                ),
                Container(
                  width: 260.w,
                  child: Text(
                    title,
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
                Container(
                  width: 24.w,
                  height: 24.w,
                )
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

SliverPadding buildBottomLoading(bool isMore) {
  return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
      sliver: SliverToBoxAdapter(
        child: isMore
            ? Container(
                margin: EdgeInsets.only(bottom: 50.w),
                child: Align(
                    alignment: Alignment.center,
                    child: Text("Data list loading...",
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.normal,
                          fontSize: 14.sp,
                        ))),
              )
            : Container(
                margin: EdgeInsets.only(bottom: 50.w),
              ),
      ));
}
