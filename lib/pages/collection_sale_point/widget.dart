import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/colors.dart';
import 'logic.dart';

class BuildListItem extends StatelessWidget {
  final AgentCollectRecordData item;
  const BuildListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: null,
              content: Container(
                height: 360.h,
                padding: EdgeInsets.only(
                    top: 20.h, left: 16.w, right: 16.w, bottom: 20.h),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Result".tr() + ":",
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
                        "Name".tr() +
                            ": ${item.businessName ?? item.firstName}",
                        textAlign: TextAlign.center,
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
                        "Phone Number".tr() + ": ${item.phone}",
                        textAlign: TextAlign.center,
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
                        "Amount".tr() + ": ${item.amount}",
                        textAlign: TextAlign.center,
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
                        "Time".tr() + ": ${timeFormated(item.createdAt)}",
                        textAlign: TextAlign.center,
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
                    GestureDetector(
                        child: Container(
                            height: 40.h,
                            width: 140.w,
                            margin: EdgeInsets.only(
                                top: 20.h, left: 0.w, right: 0.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryElement,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.w)),
                            ),
                            child: Center(
                                child: Text(
                              "PDF Print".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryBackground,
                                fontWeight: FontWeight.normal,
                                fontSize: 16.sp,
                              ),
                            ))),
                        onTap: () async {
                          TransferCollectionData data =
                              TransferCollectionData();
                          data.id = item.id;
                          data.amount = item.amount;
                          data.name = item.businessName ?? item.firstName;
                          data.phone = item.phone;
                          data.createdAt = item.createdAt;
                          var res = await printPdf(data);
                          if (res) {
                            Navigator.of(context).pop();
                          }
                        }),
                    GestureDetector(
                        child: Container(
                            height: 40.h,
                            width: 140.w,
                            margin: EdgeInsets.only(
                                top: 20.h, left: 0.w, right: 0.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryElement,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.w)),
                            ),
                            child: Center(
                                child: Text(
                              "Cancel".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryBackground,
                                fontWeight: FontWeight.normal,
                                fontSize: 16.sp,
                              ),
                            ))),
                        onTap: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            );
          },
        );
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
              child: Image.asset('assets/icons/money2.png'),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 170.w,
                  margin: EdgeInsets.only(top: 5.w),
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
          ],
        ),
      ),
    );
  }
}
