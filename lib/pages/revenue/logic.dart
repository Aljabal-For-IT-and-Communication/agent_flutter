import 'package:app/common/apis/agent.dart';
import 'package:app/common/apis/sale_point.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:app/common/widgets/widgets.dart';
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
    agent();
    salePoint();
  }

  salePoint() async {
    try {
      var result = await SalePointAPI.salePointList();
      if (result.code == 0) {
        context.read<RevenueBloc>().add(SalePointChanged(result.data!));
        context
            .read<RevenueBloc>()
            .add(SalePointItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  agent() async {
    try {
      var result = await AgentAPI.agentList();
      if (result.code == 0) {
        context.read<RevenueBloc>().add(AgentListChanged(result.data!));
        context.read<RevenueBloc>().add(AgentItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  postTransformation() async {
    final state = context.read<RevenueBloc>().state;

    FocusManager.instance.primaryFocus?.unfocus();

    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    TransferRequestEntity entity = TransferRequestEntity();

    entity.id =
        state.agent == "Agent" ? state.agentItem?.id : state.salePointItem?.id;
    entity.Category = state.agent;
    entity.Amount = state.Amount;
    entity.page = state.agentCollectRecordList.length;
    try {
      var result =
          await SalePointAPI.salePointCollectRecordList(params: entity);
      EasyLoading.dismiss();
      if (result.code == 0 && result.data != null) {
        if (result.data!.isNotEmpty) {
          var agentCollectRecordList = state.agentCollectRecordList.toList();
          agentCollectRecordList.addAll(result.data!);
          context
              .read<RevenueBloc>()
              .add(AgentCollectRecordListChanged(agentCollectRecordList));
        }
      }
      context.read<RevenueBloc>().add(IsMoreChanged(false));
    } catch (e) {
      context.read<RevenueBloc>().add(IsMoreChanged(false));
      EasyLoading.dismiss();
      toastInfo(msg: 'internet error');
      Logger.write("${e}");
    }
  }
}
