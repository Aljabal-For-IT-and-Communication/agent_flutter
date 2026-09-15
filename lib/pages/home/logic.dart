import 'package:app/common/apis/apis.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/logger.dart';
import 'package:app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class Logic {
  final BuildContext context;
  Logic({
    required this.context,
  });
  Future<void> init() async {
    await Future.wait(
        [shippingOperation(), pendingTransactions(), getProfile()]);
  }

  Future<void> shippingOperation() async {
    final bloc = context.read<HomeBloc>();
    final request = ++bloc.shippingRequestVersion;
    try {
      PageRequestEntity entity = PageRequestEntity();
      entity.title = "";
      entity.page = 0;
      var result = await HomeAPI.shippingOperationList(params: entity);
      if (bloc.isClosed || request != bloc.shippingRequestVersion) return;
      if (result.code == 0) {
        bloc.add(ShippingOperationChanged(result.data ?? []));
      } else {
        Logger.write("shippingOperationList failed: ${result.msg}");
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  Future<void> pendingTransactions() async {
    final bloc = context.read<HomeBloc>();
    final request = ++bloc.pendingRequestVersion;
    try {
      final result = await HomeAPI.pendingTransactionsList();
      if (bloc.isClosed || request != bloc.pendingRequestVersion) return;
      if (result.code == 0) {
        bloc.add(PendingTransactionsChanged(result.data ?? []));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  Future<void> getProfile() async {
    final bloc = context.read<HomeBloc>();
    final request = ++bloc.profileRequestVersion;
    try {
      var result = await UserAPI.getProfile();
      if (bloc.isClosed || request != bloc.profileRequestVersion) return;
      if (result.code == 0) {
        final userItem = result.data;
        if (userItem == null) return;
        await Global.storageService.setUserProfile(userItem);
        if (bloc.isClosed || request != bloc.profileRequestVersion) return;
        bloc.add(UserProfileChanged(userItem));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }
}
