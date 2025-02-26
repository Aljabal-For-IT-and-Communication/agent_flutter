import 'package:app/common/entities/entities.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';
import 'logic.dart';

class MyReportPage extends StatefulWidget {
  const MyReportPage({Key? key}) : super(key: key);

  @override
  State<MyReportPage> createState() => _MyReportPageState();
}

class _MyReportPageState extends State<MyReportPage> {
  ScrollController scrollController = ScrollController();
  var lastPostCalled;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        Logic(context: context).init();
      }
    });
    scrollController.addListener(() {
      if ((scrollController.offset + 10) > scrollController.position.maxScrollExtent) {
        if (lastPostCalled == null || DateTime.now().difference(lastPostCalled!) > Duration(seconds: 2)) {
          setState(() {
            lastPostCalled = DateTime.now();
          });
          context.read<MyReportBloc>().add(IsMoreChanged(true));
          final state = context.read<MyReportBloc>().state;
          if(state.agent=="shipment report"){
            Logic(context: context).postTransformation(state.superRechargeRecordList.length);
          }else{
            Logic(context: context).postTransformation(state.childRechargeRecordList.length);
          }

        }
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
    return BlocBuilder<MyReportBloc, MyReportState>(
        builder: (context, state) {
      return Container(
          color: AppColors.primaryBackground,
          child: CustomScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.w,
                  horizontal: 0.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildPublicAppBar(title: "My Report".tr()),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildDropdownAgentInput(),
                )),

            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 20.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildBtn(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.w,
                  horizontal: 16.w,
                ),
                sliver: SliverVisibility(visible:state.agent=="shipment report",sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {

                      SuperRechargeRecordData item =state.superRechargeRecordList.elementAt(index);
                      return BuildListItem(item: item);
                    },
                    childCount: state.superRechargeRecordList.length,
                  ),
                ),replacementSliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {

                      ChildRechargeRecordData item =state.childRechargeRecordList.elementAt(index);
                      return BuildChildListItem(item: item);
                    },
                    childCount: state.childRechargeRecordList.length,
                  ),
                ),)),
            buildBottomLoading(state.isMore),
          ]));
    });
  }
}
