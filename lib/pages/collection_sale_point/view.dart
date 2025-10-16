import 'package:app/common/entities/entities.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';
import 'logic.dart';

class CollectionSalePointPage extends StatefulWidget {
  const CollectionSalePointPage({Key? key}) : super(key: key);

  @override
  State<CollectionSalePointPage> createState() =>
      _CollectionSalePointPageState();
}

class _CollectionSalePointPageState extends State<CollectionSalePointPage> {
  ScrollController scrollController = ScrollController();
  var lastPostCalled;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        context
            .read<CollectionSalePointBloc>()
            .add(AgentCollectRecordListChanged([]));
        context.read<CollectionSalePointBloc>().add(IsMoreChanged(false));
        DateRequestEntity entity = DateRequestEntity();
        entity.startDate = "";
        entity.endDate = "";
        entity.page = 0;
        Logic(context: context).postTransferCollection(entity);
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
          context.read<CollectionSalePointBloc>().add(IsMoreChanged(true));
          final state = context.read<CollectionSalePointBloc>().state;
          DateRequestEntity entity = DateRequestEntity();
          entity.startDate = state.startDate;
          entity.endDate = state.endDate;
          entity.page = state.agentCollectRecordList.length;
          Logic(context: context).postTransferCollection(entity);
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
    return BlocBuilder<CollectionSalePointBloc, CollectionSalePointState>(
        builder: (context, state) {
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
                      child: BuildPublicAppBar(
                          title: "Point of sale collections".tr()),
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
