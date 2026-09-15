import 'package:app/common/apis/apis.dart';
import 'package:app/common/apis/home.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'bloc.dart';

class Logic {
  final BuildContext context;
  Logic({
    required this.context,
  });

  init() {}

  Future<void> shippingOperation(String day, int page,
      {bool refresh = false}) async {
    final bloc = context.read<ShippingOperationBloc>();
    final state = bloc.state;
    final request = ++bloc.recordsRequestVersion;
    final entity = PageRequestEntity()
      ..title = day
      ..page = page;
    if (!refresh) {
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
    }
    try {
      final result = await HomeAPI.shippingOperationList(params: entity);
      if (bloc.isClosed || request != bloc.recordsRequestVersion) return;
      if (result.code == 0 && result.data != null) {
        final records = page == 0
            ? result.data!.toList()
            : [...state.shippingOperationList, ...result.data!];
        bloc.add(ShippingOperationChanged(records));
      }
    } catch (error) {
      Logger.write('$error');
    } finally {
      if (!refresh) EasyLoading.dismiss();
      if (!bloc.isClosed && request == bloc.recordsRequestVersion) {
        bloc.add(IsMoreChanged(false));
      }
    }
  }
}
