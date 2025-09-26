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
      // Build filtered and sorted copies locally without changing original state lists
      List<SalePointData> salePoints = List.of(state.salePointList);
      if (state.salePointSearch.trim().isNotEmpty) {
        final q = state.salePointSearch.toLowerCase();
        salePoints = salePoints
            .where((e) =>
                (e.businessName ?? '').toString().toLowerCase().contains(q))
            .toList();
      }
      if (state.salePointSortField != SortField.none) {
        salePoints.sort((a, b) {
          int cmp = 0;
          switch (state.salePointSortField) {
            case SortField.balance:
              final av = double.tryParse(a.balance ?? '0') ?? 0;
              final bv = double.tryParse(b.balance ?? '0') ?? 0;
              cmp = av.compareTo(bv);
              break;
            case SortField.indebtedness:
              final av = double.tryParse(a.indebtedness ?? '0') ?? 0;
              final bv = double.tryParse(b.indebtedness ?? '0') ?? 0;
              cmp = av.compareTo(bv);
              break;
            case SortField.none:
              break;
          }
          return state.salePointSortAsc ? cmp : -cmp;
        });
      }

      List<AgentData> agents = List.of(state.agentList);
      if (state.agentSearch.trim().isNotEmpty) {
        final q = state.agentSearch.toLowerCase();
        agents = agents
            .where(
                (e) => (e.firstName ?? '').toString().toLowerCase().contains(q))
            .toList();
      }
      if (state.agentSortField != SortField.none) {
        agents.sort((a, b) {
          int cmp = 0;
          switch (state.agentSortField) {
            case SortField.balance:
              final av = double.tryParse(a.balance ?? '0') ?? 0;
              final bv = double.tryParse(b.balance ?? '0') ?? 0;
              cmp = av.compareTo(bv);
              break;
            case SortField.indebtedness:
              final av = double.tryParse(a.indebtedness ?? '0') ?? 0;
              final bv = double.tryParse(b.indebtedness ?? '0') ?? 0;
              cmp = av.compareTo(bv);
              break;
            case SortField.none:
              break;
          }
          return state.agentSortAsc ? cmp : -cmp;
        });
      }
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
                  child: Column(
                    children: [
                      Row(
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
                          Row(children: [
                            // Sort by balance toggle
                            IconButton(
                              onPressed: () {
                                context.read<SalePointBloc>().add(
                                    ToggleSalePointSort(SortField.balance));
                              },
                              tooltip:
                                  (state.salePointSortField == SortField.balance
                                          ? (state.salePointSortAsc
                                              ? 'Balance asc'
                                              : 'Balance desc')
                                          : 'Sort by balance')
                                      .tr(),
                              icon: Icon(Icons.account_balance_wallet_outlined,
                                  color: state.salePointSortField ==
                                          SortField.balance
                                      ? AppColors.primaryA
                                      : AppColors.primaryText),
                            ),
                            // Sort by indebtedness toggle
                            IconButton(
                              onPressed: () {
                                context.read<SalePointBloc>().add(
                                    ToggleSalePointSort(
                                        SortField.indebtedness));
                              },
                              tooltip: (state.salePointSortField ==
                                          SortField.indebtedness
                                      ? (state.salePointSortAsc
                                          ? 'Debt asc'
                                          : 'Debt desc')
                                      : 'Sort by debt')
                                  .tr(),
                              icon: Icon(Icons.trending_down,
                                  color: state.salePointSortField ==
                                          SortField.indebtedness
                                      ? AppColors.primaryA
                                      : AppColors.primaryText),
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
                          ])
                        ],
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by business name'.tr(),
                          isDense: true,
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 8.h),
                        ),
                        onChanged: (v) => context
                            .read<SalePointBloc>()
                            .add(SalePointSearchChanged(v)),
                      ),
                    ],
                  ),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.h,
                  horizontal: 16.w,
                ),
                sliver: salePoints.isEmpty
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
                          SalePointData item = salePoints.elementAt(index);
                          return BuildListItem(item: item);
                        },
                        childCount: salePoints.length,
                      ))),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.w,
                  horizontal: 16.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
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
                          Row(children: [
                            IconButton(
                              onPressed: () {
                                context
                                    .read<SalePointBloc>()
                                    .add(ToggleAgentSort(SortField.balance));
                              },
                              tooltip:
                                  (state.agentSortField == SortField.balance
                                          ? (state.agentSortAsc
                                              ? 'Balance asc'
                                              : 'Balance desc')
                                          : 'Sort by balance')
                                      .tr(),
                              icon: Icon(Icons.account_balance_wallet_outlined,
                                  color:
                                      state.agentSortField == SortField.balance
                                          ? AppColors.primaryA
                                          : AppColors.primaryText),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<SalePointBloc>().add(
                                    ToggleAgentSort(SortField.indebtedness));
                              },
                              tooltip: (state.agentSortField ==
                                          SortField.indebtedness
                                      ? (state.agentSortAsc
                                          ? 'Debt asc'
                                          : 'Debt desc')
                                      : 'Sort by debt')
                                  .tr(),
                              icon: Icon(Icons.trending_down,
                                  color: state.agentSortField ==
                                          SortField.indebtedness
                                      ? AppColors.primaryA
                                      : AppColors.primaryText),
                            ),
                          ])
                        ],
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by first name'.tr(),
                          isDense: true,
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 8.h),
                        ),
                        onChanged: (v) => context
                            .read<SalePointBloc>()
                            .add(AgentSearchChanged(v)),
                      ),
                    ],
                  ),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.h,
                  horizontal: 16.w,
                ),
                sliver: agents.isEmpty
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
                          AgentData item = agents.elementAt(index);
                          return BuildAgentListItem(item: item);
                        },
                        childCount: agents.length,
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
