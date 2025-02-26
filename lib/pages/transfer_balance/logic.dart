
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
import 'bloc.dart';

class Logic{
  final BuildContext context;
  Logic({
    required this.context,
  });

  init(){
    agent();
    salePoint();
    getProfile();
  }

  salePoint() async {
    try {
      var result = await SalePointAPI.salePointList();
      if (result.code == 0) {
        context.read<TransferBalanceBloc>().add(SalePointChanged(result.data!));
        context.read<TransferBalanceBloc>().add(SalePointItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }
  agent() async {
    try {
      var result = await AgentAPI.agentList();
      if (result.code == 0) {
        context.read<TransferBalanceBloc>().add(AgentListChanged(result.data!));
        context.read<TransferBalanceBloc>().add(AgentItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  getProfile() async {
    try {
      final user = context.read<TransferBalanceBloc>().state.userProfile;
      var result = await UserAPI.getProfile();
      if (result.code == 0) {
        var userItem = result.data;
        userItem?.accessToken = user?.accessToken;
        Global.storageService.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(userItem));
        context.read<TransferBalanceBloc>().add(UserProfileChanged(userItem!));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  postTransformation() async{
    final state = context.read<TransferBalanceBloc>().state;
    String Amount = state.Amount;
    String phone = state.phone;
    // if(phone.isEmpty){
    //   toastInfo(msg: "First Name not empty!");
    //   return;
    // }
    if(Amount.isEmpty){
      toastInfo(msg: "Amount not empty!");
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    TransferBalanceRequestEntity entity =  TransferBalanceRequestEntity();

    entity.id = state.agent=="Agent"?state.agentItem?.id:state.salePointItem?.id;
    entity.category = state.agent;
    entity.amount = state.Amount;
    entity.converter = state.type;
    try {
      var result = await SalePointAPI.transferBalance(params: entity);
      EasyLoading.dismiss();
      toastInfo(msg: "${result.msg}");
      if (result.code == 0) {
         Navigator.pop(context,"ok");
      }
    } catch (e) {
      EasyLoading.dismiss();
      toastInfo(msg: 'internet error');
      Logger.write("${e}");
    }
  }


}