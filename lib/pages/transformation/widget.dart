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
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/icons/headbg.png'),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // GestureDetector(
                //   onTap:(){Navigator.pop(context);},
                //   child: Container(
                //     width: 24.w,
                //     height: 24.w,
                //     child: Icon(Icons.arrow_back,color: AppColors.primaryBackground,),
                //   ),
                // ),
                Container(
                  width: 260.w,
                  child: Text(
                    "Transferring balances printed".tr(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                //Container()
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
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
            height: 0.h,
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

class BuildInput extends StatelessWidget {
  final String name;
  const BuildInput({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            "${name}",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Container(
          width: 330.w,
          height: 46.h,
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          decoration: BoxDecoration(
              color: AppColors.primaryFourElementText,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryFourElementText)),
          child: TextField(
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: "",
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              hintStyle: TextStyle(
                color: AppColors.primaryThreeElementText,
              ),
            ),
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
            onChanged: (value) {
              // context.read<RegisterBloc>().add(UserNameChanged(value));
            },
            maxLines: 1,
            autocorrect: false, // 自动纠正
            obscureText: false, // 隐藏输入内容, 密码框
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}

class BuildBtn extends StatelessWidget {
  const BuildBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child: Container(
            height: 46.h,
            width: 160.w,
            margin: EdgeInsets.only(top: 10.h, left: 0.w, right: 0.w),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
            ),
            child: Center(
                child: Text(
              "choose".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
            ))),
        onTap: () {
          //  Logic(context: context).handleRegister();
        });
  }
}
