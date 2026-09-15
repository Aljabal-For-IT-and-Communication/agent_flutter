import 'package:app/common/apis/agent.dart';
import 'package:app/common/apis/sale_point.dart';
import 'package:app/common/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class Logic {
  final BuildContext context;
  Logic({
    required this.context,
  });

  Future<void> init() async {
    await Future.wait([salePoint(), agent()]);
  }

  Future<void> salePoint() async {
    final bloc = context.read<SalePointBloc>();
    final request = ++bloc.salePointRequestVersion;
    try {
      var result = await SalePointAPI.salePointList();
      if (result.code == 0 && result.data != null) {
        if (bloc.isClosed || request != bloc.salePointRequestVersion) return;
        bloc.add(SalePointChanged(result.data!));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  Future<void> agent() async {
    final bloc = context.read<SalePointBloc>();
    final request = ++bloc.agentRequestVersion;
    try {
      var result = await AgentAPI.agentList();
      if (bloc.isClosed || request != bloc.agentRequestVersion) return;
      if (result.code == 0 && result.data != null) {
        bloc.add(AgentListChanged(result.data!));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }
}
