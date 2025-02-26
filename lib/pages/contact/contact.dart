import 'package:app/common/routes/names.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: AppColors.primaryBackground,
      child: CustomScrollView(slivers: [
        SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 0.w,
              horizontal: 0.w,
            ),
            sliver: SliverToBoxAdapter(
              child:BuildPublicAppBar(title:"Contact us".tr()),
            )),
      SliverPadding(
        padding: EdgeInsets.symmetric(
          vertical: 0.w,
          horizontal: 30.w,
        ),
        sliver: SliverToBoxAdapter(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(40.w),
                child: Image.asset("assets/icons/logo1.png"),
              ),
              SizedBox(height: 30.h,),
              Container(
                child: Text(
                  "Contact us to answer all your".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              Container(
                child: Text(
                  "inquiries: Phone number:".tr()+" +218919491111",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],),
        ),
      ),
    ]),);
  }
}


