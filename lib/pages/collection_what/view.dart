import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/routes.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  var lastPostCalled;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        context.read<CollectionWhatBloc>().add(AgentCollectRecordListChanged([]));
        context.read<CollectionWhatBloc>().add(IsMoreChanged(false));
        DateRequestEntity entity = DateRequestEntity();
        entity.startDate = "";
        entity.endDate = "";
        entity.page = 0;
        Logic(context: context).postTransferCollection(entity);
      }
    });
    scrollController.addListener(() {
      if ((scrollController.offset + 10) > scrollController.position.maxScrollExtent) {
        if (lastPostCalled == null || DateTime.now().difference(lastPostCalled!) > Duration(seconds: 2)) {
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
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.w,
                  horizontal: 0.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildPublicAppBar(title: "What has been collected?".tr()),
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
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        print('confirm $date');
                                        String month = "${date.month}";
                                        String day = "${date.day}";
                                        if(date.month<10) {
                                          month = "0${date.month}";
                                        }
                                        if(date.day<10) {
                                          day = "0${date.day}";
                                        }
                                        String days = "${date.year}-$month-$day";
                                        context.read<CollectionWhatBloc>().add(StartDateChanged(days));
                                      },
                                      onCancel: (){
                                        context.read<CollectionWhatBloc>().add(StartDateChanged(""));
                                      },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.en);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.w)),
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
                                    color:
                                    AppColors.primarySecondaryElementText,
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
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        print('confirm $date');
                                        String month = "${date.month}";
                                        String day = "${date.day}";
                                        if(date.month<10) {
                                          month = "0${date.month}";
                                        }
                                        if(date.day<10) {
                                          day = "0${date.day}";
                                        }
                                        String days = "${date.year}-$month-$day";
                                        context.read<CollectionWhatBloc>().add(EndDateChanged(days));
                                      },
                                      onCancel: (){
                                        context.read<CollectionWhatBloc>().add(EndDateChanged(""));
                                      },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.en);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.w)),
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
                                    color:
                                    AppColors.primarySecondaryElementText,
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
                        onTap: (){
                          if(state.startDate==""){
                            toastInfo(msg: "please select date from".tr());
                            return;
                          }
                          if(state.endDate==""){
                            toastInfo(msg: "please select date to".tr());
                            return;
                          }
                          DateTime date1 = DateTime.parse(state.startDate!);
                          DateTime date2 = DateTime.parse(state.endDate!);
                          if (date1.isAfter(date2)) {
                            toastInfo(msg: "date from not After date to!".tr());
                            return;
                          }

                          context.read<CollectionWhatBloc>().add(AgentCollectRecordListChanged([]));
                          context.read<CollectionWhatBloc>().add(IsMoreChanged(false));
                          DateRequestEntity entity = DateRequestEntity();
                          entity.startDate = state.startDate;
                          entity.endDate = state.endDate;
                          entity.page = 0;
                          Logic(context: context).postTransferCollection(entity);
                        },
                        child: Container(
                          width: 160.w,
                          height: 46.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primaryElement,
                            borderRadius: BorderRadius.all(Radius.circular(8.w)),
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
                      AgentCollectRecordData item =state.agentCollectRecordList.elementAt(index);
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
