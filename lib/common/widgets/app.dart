import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/values.dart';

///  AppBar
AppBar buildAppBar(String title) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    centerTitle: true,
    title: Container(
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
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
  final bool showBack;
  BuildPublicAppBar({
    Key? key,
    required this.title,
    this.onBack,
    this.showBack = true,
  }) : super(key: key);

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
          fit: BoxFit.fill,
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
            child: showBack
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (onBack != null) {
                            onBack!();
                          } else {
                            Navigator.pop(context);
                          }
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
                      _PublicAppBarTitle(title: title, width: 240.w),
                      Container(
                        width: 40.w,
                        height: 40.w,
                      )
                    ],
                  )
                : _PublicAppBarTitle(title: title, width: 260.w),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

class _PublicAppBarTitle extends StatelessWidget {
  final String title;
  final double width;

  const _PublicAppBarTitle({
    required this.title,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Text(
        title,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.primaryBackground,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
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
