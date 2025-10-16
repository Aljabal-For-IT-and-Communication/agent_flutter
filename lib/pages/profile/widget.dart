import 'package:app/common/entities/entities.dart';
import 'package:app/common/values/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/values/colors.dart';

class BuildHead extends StatelessWidget {
  final UserItem item;
  const BuildHead({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            margin: EdgeInsets.only(top: 0.h),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40.w)),
            ),
            child: item.avatar == null
                ? Image.asset('assets/images/head1.png')
                : Image.network("${SERVER_API_URL}${item.avatar}"),
          ),
          Container(
            width: 240.w,
            margin: EdgeInsets.only(left: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 240.w,
                  child: Text(
                    "${item.firstName}",
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                Container(
                  width: 343.w,
                  child: Text(
                    item.email ?? "",
                    style: TextStyle(
                      color: AppColors.primarySecondaryElementText,
                      fontWeight: FontWeight.normal,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BuildProfileView extends StatelessWidget {
  const BuildProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: AppColors.primaryFourElementText,
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 15.h, bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "Profile Completion",
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "60%",
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          LinearProgressIndicator(
            value: 0.6,
            minHeight: 5.h,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            backgroundColor: AppColors.primaryBgItem,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryElement),
          ),
          GestureDetector(
              child: Container(
                  width: 120.w,
                  height: 28.h,
                  margin: EdgeInsets.only(top: 15.h, left: 0.w, right: 0.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.all(Radius.circular(5.w)),
                  ),
                  child: Center(
                      child: Text(
                    "Complete Profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                    ),
                  ))),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.Account);
              })
        ],
      ),
    );
  }
}

class BuildMenuItem extends StatelessWidget {
  final String title;
  final String description;
  final Function()? callFunc;
  const BuildMenuItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.callFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: callFunc,
      child: Card(
        color: AppColors.primaryBackground,
        shadowColor: AppColors.primaryThreeElementText.withOpacity(0.3),
        surfaceTintColor: AppColors.primaryBackground,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          width: 343.w,
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primarySecondaryElementText,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 24.h,
                height: 24.h,
                child: Image.asset(
                  "assets/images/arrow_right.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
