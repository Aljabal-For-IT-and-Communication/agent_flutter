import 'dart:convert';

import 'package:app/common/apis/agent.dart';
import 'package:app/common/apis/apis.dart';
import 'package:app/common/apis/sale_point.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:app/common/values/constant.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'bloc.dart';

class Logic {
  final BuildContext context;
  Logic({
    required this.context,
  });

  init({bool isLocked = false}) {
    if (!isLocked) {
      agent();
      salePoint();
    }
    rechargeTypes();
    getProfile();
  }

  salePoint() async {
    try {
      // Clear existing list before fetching to avoid stale data
      context.read<TransferBalanceBloc>().add(const SalePointChanged([]));
      var result = await SalePointAPI.salePointPickerList();
      if (result.code == 0) {
        context.read<TransferBalanceBloc>().add(SalePointChanged(result.data!));
        // context.read<TransferBalanceBloc>().add(SalePointItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  agent() async {
    try {
      // Clear existing list before fetching to avoid stale data
      context.read<TransferBalanceBloc>().add(const AgentListChanged([]));
      var result = await AgentAPI.agentPickerList();
      if (result.code == 0) {
        context.read<TransferBalanceBloc>().add(AgentListChanged(result.data!));
        // context.read<TransferBalanceBloc>().add(AgentItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  rechargeTypes() async {
    try {
      var result = await SalePointAPI.rechargeTypesList();
      if (result.code == 0) {
        context
            .read<TransferBalanceBloc>()
            .add(RechargeTypesChanged(result.data ?? []));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  getProfile() async {
    try {
      final user = context.read<TransferBalanceBloc>().state.userProfile ??
          Global.storageService.getUserProfile();
      var result = await UserAPI.getBalanceSummary();
      if (result.code == 0) {
        var userItem = user;
        userItem.accessToken = user.accessToken;
        userItem.balance = result.data?.balance ?? userItem.balance;
        userItem.indebtedness =
            result.data?.indebtedness ?? userItem.indebtedness;
        Global.storageService
            .setString(STORAGE_USER_PROFILE_KEY, jsonEncode(userItem));
        context.read<TransferBalanceBloc>().add(UserProfileChanged(userItem));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  postTransformation() async {
    final state = context.read<TransferBalanceBloc>().state;
    String Amount = state.Amount;
    // String phone = state.phone;
    // if(phone.isEmpty){
    //   toastInfo(msg: "First Name not empty!");
    //   return;
    // }
    if (Amount.isEmpty) {
      toastInfo(msg: "Amount not empty!".tr());
      return;
    }

    if (state.agentItem == null && state.salePointItem == null) {
      toastInfo(msg: "Please select agent or sale point!".tr());
      return;
    }
    if (state.agent == "SalePoint" &&
        state.type == "recharge" &&
        (state.rechargeTypeId == null)) {
      toastInfo(msg: "Please select recharge type".tr());
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    TransferBalanceRequestEntity entity = TransferBalanceRequestEntity();

    entity.id =
        state.agent == "Agent" ? state.agentItem?.id : state.salePointItem?.id;
    entity.category = state.agent;
    entity.amount = state.Amount;
    entity.converter = state.type;
    if (state.agent == "SalePoint" && state.type == "recharge") {
      entity.transferType = state.rechargeTypeId;
      // If selected recharge type needs validation, ensure file is picked
      final selected = state.rechargeTypes.firstWhere(
          (e) => e.id == state.rechargeTypeId,
          orElse: () => RechargeTypeData());
      final needsValidation = selected.needsValidation ?? false;
      if (needsValidation) {
        if (state.validationFilePath == null ||
            state.validationFilePath!.isEmpty) {
          EasyLoading.dismiss();
          toastInfo(msg: "Please attach validation document".tr());
          return;
        }
        entity.validationFilePath = state.validationFilePath;
        entity.validationFileName = state.validationFileName;
      }
    }
    try {
      var result = await SalePointAPI.transferBalance(params: entity);
      EasyLoading.dismiss();
      toastInfo(msg: trServerMessage("${result.msg}"));
      if (result.code == 0) {
        if (state.isLocked) {
          // Pop back to sale_point_detail with result data
          Navigator.of(context).pop({
            'type': state.type,
            'amount': state.Amount,
          });
        } else {
          // Clear all fields and dropdowns, then reload lists/profile
          context.read<TransferBalanceBloc>().add(const ResetTransferBalance());
          Logic(context: context).init();
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      toastInfo(msg: trServerMessage('internet error'));
      Logger.write("${e}");
    }
  }
}
