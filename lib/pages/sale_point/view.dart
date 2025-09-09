import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/values/values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';
import 'logic.dart';

class SalePointPage extends StatefulWidget {
  const SalePointPage({Key? key}) : super(key: key);

  @override
  State<SalePointPage> createState() => _SalePointPageState();
}

class _SalePointPageState extends State<SalePointPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
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
    return BlocBuilder<SalePointBloc, SalePointState>(
        builder: (context, state) {
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
                  vertical: 0.w,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Sale Points List".tr(),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await Navigator.of(context)
                              .pushNamed(AppRoutes.Register);
                        },
                        icon: Icon(Icons.add),
                        color: AppColors.primaryA,
                        tooltip: 'Add'.tr(),
                        iconSize: 22.sp,
                      ),
                    ],
                  ),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.h,
                  horizontal: 16.w,
                ),
                sliver: state.salePointList.isEmpty
                    ? SliverToBoxAdapter(
                        child: Container(
                          width: 180.w,
                          child: Text(
                            "No content!".tr(),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          SalePointData item =
                              state.salePointList.elementAt(index);
                          return BuildListItem(item: item);
                        },
                        childCount: state.salePointList.length,
                      ))),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.w,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    width: 180.w,
                    child: Text(
                      "Sub Agent List".tr(),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.h,
                  horizontal: 16.w,
                ),
                sliver: state.agentList.isEmpty
                    ? SliverToBoxAdapter(
                        child: Container(
                          width: 180.w,
                          child: Text(
                            "No content!".tr(),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          AgentData item = state.agentList.elementAt(index);
                          return BuildAgentListItem(item: item);
                        },
                        childCount: state.agentList.length,
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
