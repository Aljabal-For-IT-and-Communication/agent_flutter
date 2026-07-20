import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/colors.dart';

import 'logic.dart';

class BuildAppBar extends StatelessWidget {
  BuildAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 375.w,
      padding:
          EdgeInsets.only(top: 80.h, left: 16.w, right: 16.w, bottom: 10.h),
      child: Column(
        children: [
          Container(
            width: 130.w,
            alignment: Alignment.center,
            child: Image.asset("assets/icons/logo.png"),
          ),
        ],
      ),
    );
  }
}

class BuildInput extends StatefulWidget {
  final String name;
  final Function(String)? callFunc;
  const BuildInput({Key? key, required this.name, required this.callFunc})
      : super(key: key);

  @override
  State<BuildInput> createState() => _BuildInputState();
}

class _BuildInputState extends State<BuildInput> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            widget.name,
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
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryFourElementText)),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              hintText: "",
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              suffixIconConstraints: BoxConstraints.tightFor(
                width: 44.h,
                height: 44.h,
              ),
              suffixIcon: IconButton(
                tooltip:
                    (_obscurePassword ? 'Show password' : 'Hide password').tr(),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                padding: EdgeInsets.zero,
                constraints: BoxConstraints.tightFor(
                  width: 44.h,
                  height: 44.h,
                ),
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.primarySecondaryElementText,
                  size: 22.h,
                ),
              ),
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
            onChanged: widget.callFunc,
            maxLines: 1,
            autocorrect: false,
            enableSuggestions: false,
            obscureText: _obscurePassword,
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
  BuildBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child: Container(
            width: 343.w,
            height: 50.h,
            margin: EdgeInsets.only(top: 10.h, left: 0.w, right: 0.w),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
            ),
            child: Center(
                child: Text(
              "Save changes".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
            ))),
        onTap: () {
          Logic(context: context).handleChangePassword();
        });
  }
}
