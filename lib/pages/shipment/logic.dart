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
      var result = await SalePointAPI.salePointPickerList();
      if (result.code == 0) {
        context.read<ShipmentBloc>().add(SalePointChanged(result.data!));
        context
            .read<ShipmentBloc>()
            .add(SalePointItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  agent() async {
    try {
      var result = await AgentAPI.agentPickerList();
      if (result.code == 0) {
        context.read<ShipmentBloc>().add(AgentListChanged(result.data!));
        context.read<ShipmentBloc>().add(AgentItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  postTransformation() async {
    final state = context.read<ShipmentBloc>().state;

    FocusManager.instance.primaryFocus?.unfocus();

    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    TransferRecordListRequestEntity entity = TransferRecordListRequestEntity();

    entity.id =
        state.agent == "Agent" ? state.agentItem?.id : state.salePointItem?.id;
    entity.category = state.agent;
    entity.page = state.agentRechargeRecordList.length;
    try {
      var result =
          await SalePointAPI.salePointRechargeRecordList(params: entity);
      EasyLoading.dismiss();
      if (result.code == 0 && result.data != null) {
        if (result.data!.isNotEmpty) {
          var agentRechargeRecordList = state.agentRechargeRecordList.toList();
          for (var item in result.data!) {
            if (!agentRechargeRecordList
                .any((element) => element.id == item.id)) {
              agentRechargeRecordList.add(item);
            }
          }
          context
              .read<ShipmentBloc>()
              .add(AgentRechargeRecordChanged(agentRechargeRecordList));
        }
      }
      context.read<ShipmentBloc>().add(IsMoreChanged(false));
    } catch (e) {
      context.read<ShipmentBloc>().add(IsMoreChanged(false));
      EasyLoading.dismiss();
      toastInfo(msg: trServerMessage('internet error'));
      Logger.write("${e}");
    }
  }
}
