import 'dart:io';

import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:app/common/widgets/toast.dart';
import 'package:app/pages/collection_item/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/colors.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'logic.dart';


class BuildDropdownAgentInput extends StatelessWidget {
  const BuildDropdownAgentInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> items = ['Agent', 'SalePoint'];
    var agent = context.read<CollectionItemBloc>().state.agent;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            "Agent or Sale Point".tr(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Container(
          width: 330.w,
          height: 46.h,
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryThreeElementText)),
          child: DropdownButton<String>(
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
              context.read<CollectionItemBloc>().add(IsShowChanged(false));
              context
                  .read<CollectionItemBloc>()
                  .add(AgentChanged(newValue ?? "Agent"));
            },
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}

class BuildDropdownAgentNameInput extends StatelessWidget {

  const BuildDropdownAgentNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.read<CollectionItemBloc>().state;
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
              context.read<CollectionItemBloc>().add(AgentItemChanged(newValue));
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
    var state = context.read<CollectionItemBloc>().state;
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
              return items.where((item) => item.firstName!.contains(search)).toList();
            },
            builder: (context, controller, focusNode) {
              salePointController = controller;
              return TextField(
                  controller: salePointController,
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
            itemBuilder: (context, sale_point) {
              return ListTile(
                title: Text(sale_point.firstName??""),
                subtitle: Text(sale_point.phone??""),
              );
            },
            onSelected: (SalePointData? newValue) {
              salePointController.text = newValue?.firstName??"";
              context.read<CollectionItemBloc>().add(SalePointItemChanged(newValue));
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
    var state = context.read<CollectionItemBloc>().state;

    List<AgentData> items = state.agentList.isEmpty ? [] : state.agentList;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            "First Name".tr(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Container(
          width: 330.w,
          height: 46.h,
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryThreeElementText)),
          child: DropdownButton<AgentData>(
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
              context.read<CollectionItemBloc>().add(IsShowChanged(false));
              context
                  .read<CollectionItemBloc>()
                  .add(AgentItemChanged(newValue));
            },
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}

class BuildDropdownSalePointPhoneInput extends StatelessWidget {
  const BuildDropdownSalePointPhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.read<CollectionItemBloc>().state;

    List<SalePointData> items =
        state.salePointList.isEmpty ? [] : state.salePointList;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            "First Name".tr(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Container(
          width: 330.w,
          height: 46.h,
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryThreeElementText)),
          child: DropdownButton<SalePointData>(
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
              context.read<CollectionItemBloc>().add(IsShowChanged(false));
              context
                  .read<CollectionItemBloc>()
                  .add(SalePointItemChanged(newValue));
            },
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}

class BuildPhoneInput extends StatelessWidget {
  const BuildPhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      height: 46.h,
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
          color: AppColors.primaryFourElementText,
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          border: Border.all(color: AppColors.primaryFourElementText)),
      child: TextField(
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: "Enter First Name".tr(),
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
        ),
        style: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.normal,
          fontSize: 14.sp,
        ),
        onChanged: (value) {
          context.read<CollectionItemBloc>().add(PhoneChanged(value));
        },
        maxLines: 1,
        autocorrect: false, // 自动纠正
        obscureText: false, // 隐藏输入内容, 密码框
      ),
    );
  }
}

class BuildAmountInput extends StatelessWidget {
  const BuildAmountInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 20.h),
          child: Text(
            "Amount to be collected".tr(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Container(
          width: 330.w,
          height: 46.h,
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          decoration: BoxDecoration(
              color: AppColors.primaryFourElementText,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryFourElementText)),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Amount to be collected".tr(),
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
            ),
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
            onChanged: (value) {
              context.read<CollectionItemBloc>().add(AmountChanged(value));
            },
            maxLines: 1,
            autocorrect: false, // 自动纠正
            obscureText: false, // 隐藏输入内容, 密码框
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}

class BuildCollectBtn extends StatelessWidget {
  const BuildCollectBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child: Container(
            height: 46.h,
            width: 160.w,
            margin: EdgeInsets.only(top: 20.h, left: 0.w, right: 0.w),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
            ),
            child: Center(
                child: Text(
              "collection".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
            ))),
        onTap: () async {
        //  FocusManager.instance.primaryFocus?.unfocus();
          // var state = context.read<CollectionItemBloc>().state;
          // String Amount = state.Amount;
          // String phone = state.phone;
          // // if (phone.isEmpty) {
          // //   toastInfo(msg: "First Name not empty!".tr());
          // //   return;
          // // }
          // if (Amount.isEmpty) {
          //   toastInfo(msg: "Amount not empty!".tr());
          //   return;
          // }
        //  Logic(context: context).postTransformation();

        });
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
            margin: EdgeInsets.only(top: 20.h, left: 0.w, right: 0.w),
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
         // final state = context.read<CollectionItemBloc>().state;
          // if (state.phone == "") {
          //   toastInfo(msg: "First Name is not empty");
          //   return;
          // }
          context.read<CollectionItemBloc>().add(IsShowChanged(true));
        });
  }
}
