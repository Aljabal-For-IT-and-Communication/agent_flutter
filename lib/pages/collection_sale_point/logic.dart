import 'package:app/common/apis/sale_point.dart';
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

  postTransferCollection(DateRequestEntity entity) async {
    try {
      EasyLoading.show(
          indicator: CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      var result = await SalePointAPI.transferCollectionList(params: entity);
      if (result.code == 0 && result.data != null) {
        if (result.data!.isNotEmpty) {
          final state = context.read<CollectionSalePointBloc>().state;
          var agentCollectRecordList = state.agentCollectRecordList.toList();
          agentCollectRecordList.addAll(result.data!);
          context
              .read<CollectionSalePointBloc>()
              .add(AgentCollectRecordListChanged(agentCollectRecordList));
        }
      }
      context.read<CollectionSalePointBloc>().add(IsMoreChanged(false));
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      context.read<CollectionSalePointBloc>().add(IsMoreChanged(false));
      Logger.write("${e}");
    }
  }
}
