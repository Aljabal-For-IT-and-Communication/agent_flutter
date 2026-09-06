import 'package:app/common/apis/agent.dart';
import 'package:app/common/apis/sale_point.dart';
import 'package:app/common/entities/entities.dart';
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
        await _fillLatestRecordDates(result.data!);
        context.read<SalePointBloc>().add(SalePointChanged(result.data!));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  Future<void> _fillLatestRecordDates(List<SalePointData> salePoints) async {
    await Future.wait(salePoints.map((item) async {
      if (item.id == null) return;

      if ((item.lastRechargeAt ?? '').isEmpty) {
        try {
          final result = await SalePointAPI.salePointRechargeRecordList(
            params: TransferRecordListRequestEntity(
              id: item.id,
              category: 'SalePoint',
              page: 0,
            ),
          );
          if (result.code == 0 && (result.data ?? []).isNotEmpty) {
            item.lastRechargeAt = result.data!.first.createdAt;
          }
        } catch (e) {
          Logger.write("${e}");
        }
      }

      if ((item.lastCollectAt ?? '').isEmpty) {
        try {
          final result = await SalePointAPI.salePointCollectRecordList(
            params: TransferRecordListRequestEntity(
              id: item.id,
              category: 'SalePoint',
              page: 0,
            ),
          );
          if (result.code == 0 && (result.data ?? []).isNotEmpty) {
            item.lastCollectAt = result.data!.first.createdAt;
          }
        } catch (e) {
          Logger.write("${e}");
        }
      }
    }));
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
