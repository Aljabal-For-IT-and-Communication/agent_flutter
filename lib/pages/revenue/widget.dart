import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:app/pages/revenue/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/colors.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'logic.dart';


class BuildListItem extends StatelessWidget {
  final AgentCollectRecordData item;
  const BuildListItem({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        // Navigator.of(context).pushNamed(AppRoutes.MessageDetail,arguments: item);
      },
      child: Container(
        padding: EdgeInsets.only(top: 12.h,bottom: 12.h,left: 10.w,right: 10.w),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: AppColors.primaryFourElementText,
          border: Border.all(color: AppColors.primaryThreeElementText,width: 1.h),
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width:40.w,
              height: 40.w,
              padding: EdgeInsets.all(8.w),
              clipBehavior:Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.all(Radius.circular(20.w)),
              ),
              child:  Image.asset('assets/icons/money2.png'),
            ),
            SizedBox(width: 10.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 170.w,
                  margin: EdgeInsets.only(top: 5.w),
                  child: Text(
                    "${item.businessName ?? item.firstName}",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primarySecondaryElementText,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 170.w,
                  margin: EdgeInsets.only(top: 5.w),
                  child: Text(
                    "${item.phone}",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primarySecondaryElementText,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 170.w,
                  margin: EdgeInsets.only(top: 5.w),
                  child: Text(
                    "${timeFormated(item.createdAt)}",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primarySecondaryElementText,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],),
            Container(
              width: 100.w,
              child: Text(
                "${item.amount} LYD",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),),
    );
  }
}


class BuildDropdownAgentInput extends StatelessWidget {

  const BuildDropdownAgentInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> items = ['Agent','SalePoint'];
    var agent = context.read<RevenueBloc>().state.agent;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h,top: 0.h),
          child: Text(
            "Agent or Sale Point".tr(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),),
        SizedBox(height: 6.h,),
        Container(
          width: 330.w,
          height: 46.h,
          padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
          decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryThreeElementText)
          ),
          child:  DropdownButton<String>(
            elevation: 0,
            value: agent,
            underline: Container(),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Container(
                  width: 280.w,
                  height: 40.h,
                  child: Text(item),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              print(newValue);
              context.read<RevenueBloc>().add(AgentChanged(newValue??"Agent"));
            },
          ),
        ),
        SizedBox(height: 15.h,),
      ],
    );
  }
}

class BuildDropdownAgentNameInput extends StatelessWidget {

  const BuildDropdownAgentNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.read<RevenueBloc>().state;
    TextEditingController agentController = TextEditingController();
    List<AgentData> items = state.agentList.isEmpty?[]:state.agentList;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h,top: 0.h),
          child: Text(
            "Transferred to".tr(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),),
        SizedBox(height: 6.h,),
        Container(
          width: 330.w,
          height: 46.h,
          padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 0.h),
          decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryThreeElementText)
          ),
          child:  TypeAheadField<AgentData>(
            suggestionsCallback: (search) {
              return items.where((item) => item.firstName!.contains(search)).toList();
            },
            builder: (context, controller, focusNode) {
              agentController = controller;
              return TextField(
                  controller: agentController,
                  focusNode: focusNode,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Search First Name",
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: AppColors.primaryThreeElementText,
                    ),
                  )
              );
            },
            itemBuilder: (context, agent) {
              return ListTile(
                title: Text(agent.firstName??""),
                subtitle: Text(agent.phone??""),
              );
            },
            onSelected: (AgentData? newValue) {
              agentController.text = newValue?.firstName??"";
              context.read<RevenueBloc>().add(AgentItemChanged(newValue));
            },
          ),
        ),
        SizedBox(height: 15.h,),
      ],
    );
  }
}

class BuildDropdownSalePointNameInput extends StatelessWidget {

  const BuildDropdownSalePointNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.read<RevenueBloc>().state;
    TextEditingController salePointController = TextEditingController();
    List<SalePointData> items = state.salePointList.isEmpty?[]:state.salePointList;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h,top: 0.h),
          child: Text(
            "Transferred to".tr(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),),
        SizedBox(height: 6.h,),
        Container(
          width: 330.w,
          height: 46.h,
          padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 0.h),
          decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryThreeElementText)
          ),
          child:  TypeAheadField<SalePointData>(
            suggestionsCallback: (search) {
              return items.where((item) => item.businessName!.contains(search)).toList();
            },
            builder: (context, controller, focusNode) {
              salePointController = controller;
              return TextField(
                  controller: salePointController,
                  focusNode: focusNode,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Search Business Name",
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: AppColors.primaryThreeElementText,
                    ),
                  )
              );
            },
            itemBuilder: (context, sale_point) {
              return ListTile(
                title: Text(sale_point.businessName??""),
                subtitle: Text(sale_point.phone??""),
              );
            },
            onSelected: (SalePointData? newValue) {
              salePointController.text = newValue?.businessName??"";
              context.read<RevenueBloc>().add(SalePointItemChanged(newValue));
            },
          ),
        ),
        SizedBox(height: 15.h,),
      ],
    );
  }
}

class BuildDropdownAgentPhoneInput extends StatelessWidget {

  const BuildDropdownAgentPhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.read<RevenueBloc>().state;

    List<AgentData> items = state.agentList.isEmpty?[]:state.agentList;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h,top: 0.h),
          child: Text(
            "First Name".tr(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),),
        SizedBox(height: 6.h,),
        Container(
          width: 330.w,
          height: 46.h,
          padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
          decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryThreeElementText)
          ),
          child:  DropdownButton<AgentData>(
            elevation: 0,
            value: state.agentItem,
            underline: Container(),
            items: items.map((AgentData item) {
              return DropdownMenuItem<AgentData>(
                value: item,
                child: Container(
                  width: 280.w,
                  height: 40.h,
                  child: Text("${item.firstName}"),
                ),
              );
            }).toList(),
            onChanged: (AgentData? newValue) {
              context.read<RevenueBloc>().add(AgentItemChanged(newValue));
            },
          ),
        ),
        SizedBox(height: 15.h,),
      ],
    );
  }
}

class BuildDropdownSalePointPhoneInput extends StatelessWidget {

  const BuildDropdownSalePointPhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.read<RevenueBloc>().state;

    List<SalePointData> items = state.salePointList.isEmpty?[]:state.salePointList;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h,top: 0.h),
          child: Text(
            "First Name".tr(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),),
        SizedBox(height: 6.h,),
        Container(
          width: 330.w,
          height: 46.h,
          padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
          decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryThreeElementText)
          ),
          child:  DropdownButton<SalePointData>(
            elevation: 0,
            value: state.salePointItem,
            underline: Container(),
            items: items.map((SalePointData item) {
              return DropdownMenuItem<SalePointData>(
                value: item,
                child: Container(
                  width: 280.w,
                  height: 40.h,
                  child: Text("${item.firstName}"),
                ),
              );
            }).toList(),
            onChanged: (SalePointData? newValue) {
              context.read<RevenueBloc>().add(SalePointItemChanged(newValue));
            },
          ),
        ),
        SizedBox(height: 15.h,),
      ],
    );
  }
}

class BuildBtn extends StatelessWidget {
  const BuildBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child: Container(
            height: 46.h,
            width: 160.w,
            margin: EdgeInsets.only(top: 10.h, left: 0.w, right: 0.w),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
            ),
            child: Center(
                child: Text(
                  "Search".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryBackground,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.sp,
                  ),
                ))),
        onTap: () {
          context.read<RevenueBloc>().add(IsMoreChanged(false));
          context.read<RevenueBloc>().add(AgentCollectRecordListChanged([]));
          Logic(context: context).postTransformation();
        });
  }
}