import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/colors.dart';
import 'logic.dart';



class BuildListItem extends StatelessWidget {
  final AgentCollectRecordData item;
  const BuildListItem({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        // Navigator.of(context).pushNamed(AppRoutes.MessageDetail,arguments: item);
      },
      child: Container(
        padding: EdgeInsets.only(top: 12.h,bottom: 12.h,left: 10.w,right: 10.w),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: AppColors.primaryFourElementText,
          border: Border.all(color: AppColors.primaryThreeElementText,width: 1.h),
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width:40.w,
              height: 40.w,
              padding: EdgeInsets.all(8.w),
              clipBehavior:Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.all(Radius.circular(20.w)),
              ),
              child:  Image.asset('assets/icons/money2.png'),
            ),
            SizedBox(width: 10.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 170.w,
                  margin: EdgeInsets.only(top: 5.w),
                  child: Text(
                    "${item.businessName ?? item}",
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
              ],),
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
        ),),
    );
  }
}
