import 'package:app/common/entities/entities.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';
import 'logic.dart';

class RevenuePage extends StatefulWidget {
  const RevenuePage({Key? key}) : super(key: key);

  @override
  State<RevenuePage> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
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
      if ((scrollController.offset + 10) >
          scrollController.position.maxScrollExtent) {
        if (lastPostCalled == null ||
            DateTime.now().difference(lastPostCalled!) > Duration(seconds: 2)) {
          setState(() {
            lastPostCalled = DateTime.now();
          });
          context.read<RevenueBloc>().add(IsMoreChanged(true));
          Logic(context: context).postTransformation();
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
    return BlocBuilder<RevenueBloc, RevenueState>(builder: (context, state) {
      return Container(
          color: AppColors.primaryBackground,
          child: CustomScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.w,
                      horizontal: 0.w,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: BuildPublicAppBar(title: "Revenue Report".tr()),
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
                      horizontal: 16.w,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: state.agent == "Agent"
                          ? BuildDropdownAgentNameInput()
                          : BuildDropdownSalePointNameInput(),
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
                      vertical: 20.w,
                      horizontal: 16.w,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          AgentCollectRecordData item =
                              state.agentCollectRecordList.elementAt(index);
                          return BuildListItem(item: item);
                        },
                        childCount: state.agentCollectRecordList.length,
                      ),
                    )),
                buildBottomLoading(state.isMore),
              ]));
    });
  }
}
