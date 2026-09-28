import 'package:app/common/widgets/recipient_report_controls.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:app/common/widgets/form_scroll_view.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';
import 'logic.dart';

class ShipmentPage extends StatefulWidget {
  const ShipmentPage({Key? key}) : super(key: key);

  @override
  State<ShipmentPage> createState() => _ShipmentPageState();
}

class _ShipmentPageState extends State<ShipmentPage> {
  ScrollController scrollController = ScrollController();
  var lastPostCalled;
  bool _isRefreshing = false;

  Future<void> _refresh() async {
    if (_isRefreshing) return;
    _isRefreshing = true;
    lastPostCalled = null;
    try {
      await Logic(context: context)
          .postTransformation(refresh: true, showLoading: false);
    } finally {
      _isRefreshing = false;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        Logic(context: context).init();
      }
    });
    scrollController.addListener(() {
      final state = context.read<ShipmentBloc>().state;
      // Focus scrolling and keyboard resizing must not load records or unfocus search.
      if (_isRefreshing ||
          scrollController.position.extentBefore <= 0 ||
          scrollController.position.userScrollDirection !=
              ScrollDirection.reverse ||
          state.agentRechargeRecordList.isEmpty ||
          state.isMore ||
          state.isLoading ||
          !state.hasMore) return;
      if ((scrollController.offset + 10) >
          scrollController.position.maxScrollExtent) {
        if (lastPostCalled == null ||
            DateTime.now().difference(lastPostCalled!) > Duration(seconds: 2)) {
          setState(() {
            lastPostCalled = DateTime.now();
          });
          context.read<ShipmentBloc>().add(IsMoreChanged(true));
          Logic(context: context).postTransformation();
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ShipmentBloc, ShipmentState>(builder: (context, state) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.primaryBackground,
          body: FormScrollView(
              controller: scrollController,
              onRefresh: _refresh,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.w,
                      horizontal: 0.w,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: BuildPublicAppBar(title: "Shipments report".tr()),
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
                      horizontal: 16.w,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: RecipientReportControls(
                        startDate: state.startDate,
                        endDate: state.endDate,
                        totalAmount: state.totalAmount,
                        isLoading: state.isLoading,
                        isPrinting: state.isPrinting,
                        onDatesChanged: (start, end) => context
                            .read<ShipmentBloc>()
                            .add(ReportDatesChanged(start, end)),
                        onSearch: () => Logic(context: context)
                            .postTransformation(refresh: true),
                        onPrint: () => Logic(context: context).printReport(),
                      ),
                    )),
                SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.w,
                      horizontal: 16.w,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          AgentRechargeRecordData item =
                              state.agentRechargeRecordList.elementAt(index);
                          return BuildListItem(item: item);
                        },
                        childCount: state.agentRechargeRecordList.length,
                      ),
                    )),
                buildBottomLoading(state.isMore),
              ]));
    });
  }
}
