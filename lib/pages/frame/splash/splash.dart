import 'package:app/common/routes/routes.dart';
import 'package:app/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() {
    return SplashState();
  }
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.Sign_in,
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: AppColors.primaryElement,
      body: Container(
          width: 375.w,
          margin: EdgeInsets.only(top: 220.h),
          padding: EdgeInsets.only(left: 120.w, right: 120.w),
          child: Column(
            children: [
              Container(child: Image.asset("assets/icons/logo.png")),
              SizedBox(
                height: 16.h,
              ),
              Text("Alafdal+Agents",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBackground))
            ],
          )),
    );
  }
}
