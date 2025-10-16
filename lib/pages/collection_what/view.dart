import 'package:app/common/entities/entities.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/utils/utils.dart';

import 'bloc.dart';
import 'widget.dart';
import 'logic.dart';

class CollectionWhatPage extends StatefulWidget {
  const CollectionWhatPage({Key? key}) : super(key: key);

  @override
  State<CollectionWhatPage> createState() => _CollectionWhatPageState();
}

class _CollectionWhatPageState extends State<CollectionWhatPage> {
  ScrollController scrollController = ScrollController();
  DateTime? lastPostCalled;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        context
            .read<CollectionWhatBloc>()
            .add(AgentCollectRecordListChanged([]));
        context.read<CollectionWhatBloc>().add(IsMoreChanged(false));
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
          context.read<CollectionWhatBloc>().add(IsMoreChanged(true));
          final state = context.read<CollectionWhatBloc>().state;
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
    return BlocBuilder<CollectionWhatBloc, CollectionWhatState>(
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
                          title: "What has been collected?".tr()),
                    )),
                SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 16.w,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Total amount of money collected".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            child: Text(
                              "${state.amount} LYD",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryGreen,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            child: Text(
                              "What was collected".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      final fmt =
                                          DateFormat('yyyy-MM-dd HH:mm:ss');
                                      final initial = (state.startDate !=
                                                  null &&
                                              state.startDate!.isNotEmpty)
                                          ? (() {
                                              try {
                                                return fmt
                                                    .parse(state.startDate!);
                                              } catch (_) {
                                                return DateTime.now();
                                              }
                                            })()
                                          : DateTime.now();
                                      DatePicker.showDateTimePicker(
                                        context,
                                        showTitleActions: true,
                                        onChanged: (date) {
                                          // debug print
                                          // print('change $date');
                                        },
                                        onConfirm: (date) {
                                          // format: 2006-01-02 15:04:05
                                          final formatted =
                                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                                  .format(date);
                                          context
                                              .read<CollectionWhatBloc>()
                                              .add(StartDateChanged(formatted));
                                        },
                                        onCancel: () {
                                          context
                                              .read<CollectionWhatBloc>()
                                              .add(StartDateChanged(""));
                                        },
                                        currentTime: initial,
                                        locale: pickerLocaleFrom(context),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(6.w),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryElement,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.w)),
                                      ),
                                      child: Text(
                                        "Select date from".tr(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.primaryBackground,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    child: Text(
                                      "${state.startDate}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors
                                            .primarySecondaryElementText,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      final fmt =
                                          DateFormat('yyyy-MM-dd HH:mm:ss');
                                      final initial = (state.endDate != null &&
                                              state.endDate!.isNotEmpty)
                                          ? (() {
                                              try {
                                                return fmt
                                                    .parse(state.endDate!);
                                              } catch (_) {
                                                return DateTime.now();
                                              }
                                            })()
                                          : DateTime.now();
                                      DatePicker.showDateTimePicker(
                                        context,
                                        showTitleActions: true,
                                        onChanged: (date) {
                                          // debug print
                                          // print('change $date');
                                        },
                                        onConfirm: (date) {
                                          final formatted =
                                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                                  .format(date);
                                          context
                                              .read<CollectionWhatBloc>()
                                              .add(EndDateChanged(formatted));
                                        },
                                        onCancel: () {
                                          context
                                              .read<CollectionWhatBloc>()
                                              .add(EndDateChanged(""));
                                        },
                                        currentTime: initial,
                                        locale: pickerLocaleFrom(context),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(6.w),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryElement,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.w)),
                                      ),
                                      child: Text(
                                        "Select date to".tr(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.primaryBackground,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    child: Text(
                                      "${state.endDate}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors
                                            .primarySecondaryElementText,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (state.startDate == "") {
                                toastInfo(msg: "please select date from".tr());
                                return;
                              }
                              if (state.endDate == "") {
                                toastInfo(msg: "please select date to".tr());
                                return;
                              }
                              final fmt = DateFormat('yyyy-MM-dd HH:mm:ss');
                              DateTime date1 = fmt.parse(state.startDate!);
                              DateTime date2 = fmt.parse(state.endDate!);
                              if (date1.isAfter(date2)) {
                                toastInfo(
                                    msg: "date from not After date to!".tr());
                                return;
                              }

                              context
                                  .read<CollectionWhatBloc>()
                                  .add(AgentCollectRecordListChanged([]));
                              context
                                  .read<CollectionWhatBloc>()
                                  .add(IsMoreChanged(false));
                              DateRequestEntity entity = DateRequestEntity();
                              entity.startDate =
                                  replaceArabicNumbers(state.startDate ?? "");
                              entity.endDate =
                                  replaceArabicNumbers(state.endDate ?? "");
                              entity.page = 0;
                              Logic(context: context)
                                  .postTransferCollection(entity);
                            },
                            child: Container(
                              width: 160.w,
                              height: 46.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.primaryElement,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.w)),
                              ),
                              child: Text(
                                "Search".tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.primaryBackground,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await printCollectionReportPdf(
                                  await Logic(context: context)
                                      .getAllTransferCollection());
                            },
                            child: Container(
                              width: 160.w,
                              height: 46.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.primaryElement,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.w)),
                              ),
                              child: Text(
                                "PDF Print".tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.primaryBackground,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
