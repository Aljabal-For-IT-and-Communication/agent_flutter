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

  message() async {
    try {
      final state = context.read<MessageBloc>().state;
      EasyLoading.show(
          indicator: CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);

      PageRequestEntity entity = PageRequestEntity();
      entity.title = "";
      entity.page = state.message.length;
      var result = await HomeAPI.notificationList(params: entity);
      if (result.code == 0 && result.data != null) {
        if (result.data!.isNotEmpty) {
          var message = state.message.toList();
          message.addAll(result.data!);
          context.read<MessageBloc>().add(MessageChanged(message));
        }
      }
      context.read<MessageBloc>().add(IsMoreChanged(false));
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Logger.write("${e}");
    }
  }
}
