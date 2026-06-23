import 'package:app/common/apis/sale_point.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
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

  superRechargeRecord(PageOnlyRequestEntity entity) async {
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    try {
      var result = await SalePointAPI.superRechargeRecordList(params: entity);
      EasyLoading.dismiss();
      if (result.code == 0 && result.data != null) {
        if (result.data!.isNotEmpty) {
          final state = context.read<MyReportBloc>().state;
          var superRechargeRecordList = state.superRechargeRecordList.toList();
          superRechargeRecordList.addAll(result.data!);
          context
              .read<MyReportBloc>()
              .add(SuperRechargeRecordChanged(superRechargeRecordList));
        }
      }
      context.read<MyReportBloc>().add(IsMoreChanged(false));
    } catch (e) {
      context.read<MyReportBloc>().add(IsMoreChanged(false));
      EasyLoading.dismiss();
      Logger.write("${e}");
    }
  }

  childRechargeRecord(PageOnlyRequestEntity entity) async {
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    try {
      var result = await SalePointAPI.superCollectRecordList(params: entity);
      EasyLoading.dismiss();
      if (result.code == 0 && result.data != null) {
        if (result.data!.isNotEmpty) {
          final state = context.read<MyReportBloc>().state;
          var childRechargeRecordList = state.childRechargeRecordList.toList();
          childRechargeRecordList.addAll(result.data!);
          context
              .read<MyReportBloc>()
              .add(ChildRechargeRecordChanged(childRechargeRecordList));
        }
      }
      context.read<MyReportBloc>().add(IsMoreChanged(false));
    } catch (e) {
      context.read<MyReportBloc>().add(IsMoreChanged(false));
      EasyLoading.dismiss();
      Logger.write("${e}");
    }
  }

  postTransformation(int page) async {
    final state = context.read<MyReportBloc>().state;
    PageOnlyRequestEntity entity = PageOnlyRequestEntity();
    entity.page = page;
    if (state.agent == "shipment report") {
      superRechargeRecord(entity);
    } else {
      childRechargeRecord(entity);
    }
  }
}
