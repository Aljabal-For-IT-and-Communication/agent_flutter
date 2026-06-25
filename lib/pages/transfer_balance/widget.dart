import 'package:app/common/entities/entities.dart';
import 'package:app/pages/transfer_balance/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/colors.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'logic.dart';
import 'package:file_picker/file_picker.dart';

class BuildAppBar extends StatelessWidget {
  BuildAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProfile = context.read<TransferBalanceBloc>().state.userProfile;
    return Container(
      width: 375.w,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/icons/headbg.png'),
          fit: BoxFit.fill, // 完全填充
        ),
      ),
      padding: EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w, bottom: 0.h),
      child: Column(
        children: [
          SizedBox(
            height: 25.h,
          ),
          Container(
            width: 343.w,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context
                        .read<TransferBalanceBloc>()
                        .add(const ResetTransferBalance());
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryBackground,
                      size: 28.sp,
                    ),
                  ),
                ),
                Container(
                  width: 240.w,
                  child: Text(
                    "Transfer balance".tr(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                Container(
                  width: 40.w,
                  height: 40.w,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            child: Text(
              "Current Balance".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.normal,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            child: Text(
              "${userProfile?.indebtedness ?? 0}LYD",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.normal,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

class BuildDropdownTypeInput extends StatelessWidget {
  const BuildDropdownTypeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> items = ['recharge', 'retrack'];
    var state = context.watch<TransferBalanceBloc>().state;
    var type = state.type;
    final isLocked = state.isLocked;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            "Transaction Type".tr(),
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
        Opacity(
          opacity: isLocked ? 0.6 : 1.0,
          child: Container(
            width: 330.w,
            height: 46.h,
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
            decoration: BoxDecoration(
                color: isLocked
                    ? AppColors.primaryFourElementText
                    : AppColors.primaryBackground,
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
                border: Border.all(color: AppColors.primaryThreeElementText)),
            child: DropdownButton<String>(
              elevation: 0,
              value: type,
              underline: Container(),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Container(
                    width: 280.w,
                    height: 40.h,
                    child: Text(item.tr()),
                  ),
                );
              }).toList(),
              onChanged: isLocked
                  ? null
                  : (String? newValue) {
                      final value = newValue ?? 'recharge';
                      context
                          .read<TransferBalanceBloc>()
                          .add(TypeChanged(value));
                      if (value == 'recharge') {
                        Logic(context: context).rechargeTypes();
                      }
                    },
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}

class BuildDropdownAgentInput extends StatelessWidget {
  const BuildDropdownAgentInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> items = ['Agent', 'SalePoint'];
    var state = context.watch<TransferBalanceBloc>().state;
    var agent = state.agent;
    final isLocked = state.isLocked;
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
        Opacity(
          opacity: isLocked ? 0.6 : 1.0,
          child: Container(
            width: 330.w,
            height: 46.h,
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
            decoration: BoxDecoration(
                color: isLocked
                    ? AppColors.primaryFourElementText
                    : AppColors.primaryBackground,
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
                    child: Text(item.tr()),
                  ),
                );
              }).toList(),
              onChanged: isLocked
                  ? null
                  : (String? newValue) {
                      print(newValue);
                      context
                          .read<TransferBalanceBloc>()
                          .add(AgentChanged(newValue ?? "Agent"));
                    },
            ),
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
    var state = context.read<TransferBalanceBloc>().state;
    TextEditingController agentController = TextEditingController();
    List<AgentData> items = state.agentList.isEmpty ? [] : state.agentList;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            "Transferred to".tr(),
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
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 0.h),
          decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryThreeElementText)),
          child: TypeAheadField<AgentData>(
            suggestionsCallback: (search) {
              return items
                  .where((item) => item.firstName!.contains(search))
                  .toList();
            },
            builder: (context, controller, focusNode) {
              agentController = controller;
              return TextField(
                  controller: agentController,
                  focusNode: focusNode,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Search First Name".tr(),
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
                  ));
            },
            itemBuilder: (context, agent) {
              return ListTile(
                title: Text(agent.firstName ?? ""),
                subtitle: Text(agent.phone ?? ""),
              );
            },
            onSelected: (AgentData? newValue) {
              agentController.text = newValue?.firstName ?? "";
              context
                  .read<TransferBalanceBloc>()
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

class BuildDropdownAgentPhoneInput extends StatelessWidget {
  const BuildDropdownAgentPhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.read<TransferBalanceBloc>().state;

    List<AgentData> items = state.agentList.isEmpty ? [] : state.agentList;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            "Transferred to".tr(),
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
              context
                  .read<TransferBalanceBloc>()
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

class BuildDropdownSalePointNameInput extends StatelessWidget {
  const BuildDropdownSalePointNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<TransferBalanceBloc>().state;
    final isLocked = state.isLocked;

    // When locked, show a read-only display instead of the search field
    if (isLocked && state.salePointItem != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
            child: Text(
              "Transferred to".tr(),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Opacity(
            opacity: 0.6,
            child: Container(
              width: 330.w,
              height: 46.h,
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: AppColors.primaryFourElementText,
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                  border: Border.all(color: AppColors.primaryThreeElementText)),
              child: Text(
                state.salePointItem?.businessName ??
                    state.salePointItem?.firstName ??
                    '',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),
        ],
      );
    }

    TextEditingController salePointController = TextEditingController();
    List<SalePointData> items =
        state.salePointList.isEmpty ? [] : state.salePointList;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            "Transferred to".tr(),
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
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 0.h),
          decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryThreeElementText)),
          child: TypeAheadField<SalePointData>(
            suggestionsCallback: (search) {
              return items
                  .where((item) => item.businessName!.contains(search))
                  .toList();
            },
            builder: (context, controller, focusNode) {
              salePointController = controller;
              return TextField(
                  controller: salePointController,
                  focusNode: focusNode,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Search Business Name".tr(),
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
                  ));
            },
            itemBuilder: (context, sale_point) {
              return ListTile(
                title:
                    Text(sale_point.businessName ?? sale_point.firstName ?? ""),
                subtitle: Text(sale_point.phone ?? ""),
              );
            },
            onSelected: (SalePointData? newValue) {
              salePointController.text =
                  newValue?.businessName ?? newValue?.firstName ?? "";
              context
                  .read<TransferBalanceBloc>()
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

class BuildDropdownSalePointPhoneInput extends StatelessWidget {
  const BuildDropdownSalePointPhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.read<TransferBalanceBloc>().state;

    List<SalePointData> items =
        state.salePointList.isEmpty ? [] : state.salePointList;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            "Transferred to".tr(),
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
                  child: Text("${item.businessName ?? item.firstName}"),
                ),
              );
            }).toList(),
            onChanged: (SalePointData? newValue) {
              context
                  .read<TransferBalanceBloc>()
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
    final state = context.watch<TransferBalanceBloc>().state;
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
        key: ValueKey("tb_phone_${state.formVersion}"),
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: "Enter Phone number".tr(),
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
          context.read<TransferBalanceBloc>().add(PhoneChanged(value));
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
    final state = context.watch<TransferBalanceBloc>().state;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 15.h),
          child: Text(
            "Amount to be transferred".tr(),
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
            key: ValueKey("tb_amount_${state.formVersion}"),
            decoration: InputDecoration(
              hintText: "Enter the Amount to be transferred".tr(),
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
              context.read<TransferBalanceBloc>().add(AmountChanged(value));
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

class BuildBtn extends StatelessWidget {
  const BuildBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child: Container(
            height: 46.h,
            width: 160.w,
            margin:
                EdgeInsets.only(top: 10.h, left: 0.w, right: 0.w, bottom: 20.h),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
            ),
            child: Center(
                child: Text(
              "transformation".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
            ))),
        onTap: () {
          Logic(context: context).postTransformation();
        });
  }
}

class BuildDropdownRechargeTypeInput extends StatelessWidget {
  const BuildDropdownRechargeTypeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use watch so that validation UI reacts to recharge type changes.
    var state = context.watch<TransferBalanceBloc>().state;
    List<RechargeTypeData> items =
        state.rechargeTypes.isEmpty ? [] : state.rechargeTypes;
    final selected = items.firstWhere((e) => e.id == state.rechargeTypeId,
        orElse: () => RechargeTypeData());
    final needsValidation = selected.needsValidation ?? false;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            "Recharge type".tr(),
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
          child: DropdownButton<int>(
            elevation: 0,
            value: state.rechargeTypeId,
            underline: Container(),
            items: items.map((RechargeTypeData item) {
              return DropdownMenuItem<int>(
                value: item.id,
                child: Container(
                  width: 280.w,
                  height: 40.h,
                  child: Text(
                      "${item.typeName ?? ''} ${item.profit != null ? '(' + item.profit! + ')' : ''}"),
                ),
              );
            }).toList(),
            onChanged: (int? newValue) {
              context
                  .read<TransferBalanceBloc>()
                  .add(RechargeTypeSelected(newValue));
            },
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        if (needsValidation) BuildValidationAttachmentInput(),
      ],
    );
  }
}

class BuildValidationAttachmentInput extends StatelessWidget {
  const BuildValidationAttachmentInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TransferBalanceBloc>().state;
    final hasFile = state.validationFilePath != null &&
        (state.validationFilePath!.isNotEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            "Validation document (image/pdf)".tr(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                final res = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
                );
                if (res != null && res.files.isNotEmpty) {
                  final f = res.files.first;
                  if (f.path != null) {
                    context
                        .read<TransferBalanceBloc>()
                        .add(ValidationFilePicked(f.path!, f.name));
                  }
                }
              },
              child: Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                ),
                child: Center(
                  child: Text(
                    hasFile ? "Change file".tr() : "Choose file".tr(),
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                hasFile
                    ? (state.validationFileName ?? '')
                    : "No file chosen".tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                  fontSize: 12.sp,
                ),
              ),
            ),
            if (hasFile)
              IconButton(
                icon: Icon(Icons.close, size: 20.w),
                onPressed: () {
                  context
                      .read<TransferBalanceBloc>()
                      .add(const ValidationFileCleared());
                },
              )
          ],
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
