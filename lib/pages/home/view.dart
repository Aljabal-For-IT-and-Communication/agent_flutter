import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/values/values.dart';
import 'package:app/global.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';
import 'logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<HomeBloc>().add(UserProfileChanged(UserItem()));
      if (mounted) {
        var userProfile = Global.storageService.getUserProfile();
        context.read<HomeBloc>().add(UserProfileChanged(userProfile));
        Logic(context: context).init();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Container(
          color: AppColors.primaryBackground,
          child: CustomScrollView(slivers: [
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.w,
                  horizontal: 0.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildAppBar(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: MenuView(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "Shipping operations".tr(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.ShippingOperation);
                        },
                        child: Container(
                          child: Text(
                            "More".tr(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryElement,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.h,
                  horizontal: 16.w,
                ),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    ShippingOperationData item = state.shippingOperationList.elementAt(index);
                    return BuildListItem(item: item);
                  },
                  childCount: state.shippingOperationList.length,
                ))),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 0.w,
                horizontal: 0.w,
              ),
              sliver: SliverToBoxAdapter(
                  child: SizedBox(
                height: 16.h,
              )),
            ),
          ]));
    });
  }
}
