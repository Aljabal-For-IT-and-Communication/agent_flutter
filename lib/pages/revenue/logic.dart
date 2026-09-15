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
      if (!context.mounted) return;
      if (result.code == 0 && result.data != null) {
        context.read<RevenueBloc>().add(SalePointChanged(result.data!));
        if (result.data!.isNotEmpty)
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
      if (!context.mounted) return;
      if (result.code == 0 && result.data != null) {
        context.read<RevenueBloc>().add(AgentListChanged(result.data!));
        if (result.data!.isNotEmpty)
          context.read<RevenueBloc>().add(AgentItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  Future<void> postTransformation(
      {bool refresh = false, bool showLoading = true}) async {
    final bloc = context.read<RevenueBloc>();
    final state = bloc.state;
    final id =
        state.agent == "Agent" ? state.agentItem?.id : state.salePointItem?.id;
    if (id == null) return;
    final request = ++bloc.recordsRequestVersion;
    if (showLoading) {
      FocusManager.instance.primaryFocus?.unfocus();
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
    }
    final entity = TransferRecordListRequestEntity()
      ..id = id
      ..category = state.agent
      ..page = refresh ? 0 : state.agentCollectRecordList.length;
    try {
      final result =
          await SalePointAPI.salePointCollectRecordList(params: entity);
      if (bloc.isClosed || request != bloc.recordsRequestVersion) return;
      if (result.code == 0 && result.data != null) {
        final records = refresh
            ? <AgentCollectRecordData>[]
            : state.agentCollectRecordList.toList();
        for (final item in result.data!) {
          if (!records.any((existing) => existing.id == item.id))
            records.add(item);
        }
        bloc.add(AgentCollectRecordListChanged(records));
      }
    } catch (error) {
      if (!bloc.isClosed && request == bloc.recordsRequestVersion) {
        toastInfo(msg: trServerMessage('internet error'));
        Logger.write('$error');
      }
    } finally {
      if (showLoading) EasyLoading.dismiss();
      if (!bloc.isClosed && request == bloc.recordsRequestVersion) {
        bloc.add(IsMoreChanged(false));
      }
    }
  }
}
