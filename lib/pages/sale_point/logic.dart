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

  init() {
    salePoint();
    agent();
  }

  salePoint() async {
    try {
      var result = await SalePointAPI.salePointList();
      if (result.code == 0 && result.data != null) {
        context.read<SalePointBloc>().add(SalePointChanged(result.data!));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  agent() async {
    try {
      var result = await AgentAPI.agentList();
      if (result.code == 0 && result.data != null) {
        context.read<SalePointBloc>().add(AgentListChanged(result.data!));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }
}
