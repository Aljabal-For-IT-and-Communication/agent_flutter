import 'package:app/common/routes/names.dart';
import 'package:app/common/values/values.dart';
import 'package:app/global.dart';
import 'package:app/pages/profile/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      var userProfile = Global.storageService.getUserProfile();
      context.read<ProfileBloc>().add(UserProfileChanged(userProfile));
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProfile = Global.storageService.getUserProfile();
    return BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading:false,
              title: Container(
                child: Text(
                  "Profile",
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm logout"),
                            content: Text("Confirm logout."),
                            backgroundColor: AppColors.primaryBackground,
                            actions: [
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Confirm"),
                                onPressed: () {
                                  Global.storageService.remove(STORAGE_USER_PROFILE_KEY);
                                  Global.storageService.remove(STORAGE_USER_TOKEN_KEY);
                                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.Sign_in, (Route<dynamic> route) => false);
                                },
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                    width:20.w,
                    height: 20.h,
                    margin: EdgeInsets.only(right: 16.w),
                    child: Image.asset("assets/images/logout.png",fit: BoxFit.fitWidth,),
                  ),
                )
              ],
            ),
            backgroundColor: Colors.white,
            body: CustomScrollView(slivers: [
              SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.w,
                    horizontal: 16.w,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: BuildHead(item: userProfile,),
                  )),

              SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      width: 343.w,
                      child: Column(children: [

                        SizedBox(height: 10.h,),
                        BuildMenuItem(title: "Setting",description: "Notification, Password, FAQ, Contact",callFunc: (){
                          Navigator.of(context).pushNamed(AppRoutes.Setting);
                        },),
                        SizedBox(height: 10.h,),
                      ],),
                    ),
                  )),

            ]),
          );
        });
  }
}
