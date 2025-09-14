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
    collectTypes();
  }

  salePoint() async {
    try {
      var result = await SalePointAPI.salePointList();
      if (result.code == 0) {
        context.read<CollectionItemBloc>().add(SalePointChanged(result.data!));
        // context.read<CollectionItemBloc>().add(SalePointItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  agent() async {
    try {
      var result = await AgentAPI.agentList();
      if (result.code == 0) {
        context.read<CollectionItemBloc>().add(AgentListChanged(result.data!));
        // context.read<CollectionItemBloc>().add(AgentItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  collectTypes() async {
    try {
      var result = await SalePointAPI.collectTypesList();
      if (result.code == 0) {
        context
            .read<CollectionItemBloc>()
            .add(CollectTypesChanged(result.data ?? []));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }
}
