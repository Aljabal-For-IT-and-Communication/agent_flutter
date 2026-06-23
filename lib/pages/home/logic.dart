import 'dart:convert';

import 'package:app/common/apis/apis.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/logger.dart';
import 'package:app/common/values/constant.dart';
import 'package:app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'bloc.dart';

class Logic {
  final BuildContext context;
  Logic({
    required this.context,
  });
  init() {
    shippingOperation();
    pendingTransactions();
    getProfile();
  }

  shippingOperation() async {
    try {
      PageRequestEntity entity = PageRequestEntity();
      entity.title = "";
      entity.page = 0;
      var result = await HomeAPI.shippingOperationList(params: entity);
      if (result.code == 0) {
        context
            .read<HomeBloc>()
            .add(ShippingOperationChanged(result.data ?? []));
      } else {
        Logger.write("shippingOperationList failed: ${result.msg}");
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Logger.write("${e}");
    }
  }

  pendingTransactions() async {
    try {
      final result = await HomeAPI.pendingTransactionsList();
      if (result.code == 0) {
        context
            .read<HomeBloc>()
            .add(PendingTransactionsChanged(result.data ?? []));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  getProfile() async {
    try {
      final user = context.read<HomeBloc>().state.userProfile;
      var result = await UserAPI.getProfile();
      if (result.code == 0) {
        var userItem = result.data;
        userItem?.accessToken = user?.accessToken;
        Global.storageService
            .setString(STORAGE_USER_PROFILE_KEY, jsonEncode(userItem));
        context.read<HomeBloc>().add(UserProfileChanged(userItem!));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }
}
