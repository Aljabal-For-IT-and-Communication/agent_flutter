import 'package:app/common/apis/agent.dart';
import 'package:app/common/apis/sale_point.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/services/sql_db.dart';
import 'package:app/common/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import 'package:app/common/utils/loading.dart';
import 'package:easy_localization/easy_localization.dart';

class Logic {
  final BuildContext context;
  Logic({
    required this.context,
  });

  init() {
    salePoint();
    agent();
  }

  goChat(ChatUserItem item) async {
    if (item.token != null) {
      SqlDbService sqlDbService = await SqlDbService().init();
      // await sqlDbService.deleteAllChatUser();
      var result = await sqlDbService.queryByTokenRow(item.token);
      if (result.isEmpty) {
        await sqlDbService.insertChatUser(item);
      }
      await Navigator.of(context).pushNamed(AppRoutes.Chat, arguments: item);
    }
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

  // Save edited sale point: for now just show a toast and exit editing
  void saveSalePointEdits(
    SalePointData item, {
    required String firstName,
    required String middleName,
    required String lastName,
    required String businessName,
    required String machineNumber,
  }) {
    () async {
      try {
        final res = await SalePointAPI.salePointDataUpdate(
          params: SalePointDataUpdateRequestEntity(
            id: item.id,
            firstName: firstName,
            middleName: middleName,
            lastName: lastName,
            businessName: businessName,
            machineNumber: machineNumber,
          ),
        );
        if (res.code == 0) {
          Loading.toast('Saved'.tr());
          salePoint();
          context.read<SalePointBloc>().add(const SetEditingSalePoint(null));
        } else {
          Loading.toast(res.msg ?? 'Error'.tr());
        }
      } catch (e) {
        Loading.toast('Error'.tr());
      }
    }();
  }

  // Toggle sale point status (activate/deactivate)
  void toggleSalePointStatus(SalePointData item) {
    final isActive = (item.status == 1);
    final newStatus = isActive ? 2 : 1;
    () async {
      try {
        final res = await SalePointAPI.salePointStatusUpdate(
          params: SalePointStatusUpdateRequestEntity(
            id: item.id,
            status: newStatus,
          ),
        );
        if (res.code == 0) {
          final toastMsg =
              isActive ? 'Deactivate request sent' : 'Activate request sent';
          Loading.toast(toastMsg.tr());
          salePoint();
        } else {
          Loading.toast(res.msg ?? 'Error'.tr());
        }
      } catch (e) {
        Loading.toast('Error'.tr());
      }
    }();
  }
}
