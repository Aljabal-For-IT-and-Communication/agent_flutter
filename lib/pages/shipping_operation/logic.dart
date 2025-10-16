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

  shippingOperation(String day, int page) async {
    try {
      PageRequestEntity entity = PageRequestEntity();
      entity.title = day;
      entity.page = page;
      print(page);

      var result = await HomeAPI.shippingOperationList(params: entity);
      if (result.code == 0 && result.data != null) {
        if (result.data!.isNotEmpty) {
          final state = context.read<ShippingOperationBloc>().state;
          var shippingOperationList = state.shippingOperationList.toList();
          shippingOperationList.addAll(result.data!);
          context
              .read<ShippingOperationBloc>()
              .add(ShippingOperationChanged(shippingOperationList));
          context.read<ShippingOperationBloc>().add(IsMoreChanged(false));
        }
      }
      context.read<ShippingOperationBloc>().add(IsMoreChanged(false));
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Logger.write("${e}");
      context.read<ShippingOperationBloc>().add(IsMoreChanged(false));
    }
  }
}
