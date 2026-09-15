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

  Future<void> superRechargeRecord(PageOnlyRequestEntity entity,
          {bool refresh = false}) =>
      _load(entity, recharge: true, refresh: refresh);

  Future<void> childRechargeRecord(PageOnlyRequestEntity entity,
          {bool refresh = false}) =>
      _load(entity, recharge: false, refresh: refresh);

  Future<void> _load(PageOnlyRequestEntity entity,
      {required bool recharge, required bool refresh}) async {
    final bloc = context.read<MyReportBloc>();
    final state = bloc.state;
    final request = ++bloc.recordsRequestVersion;
    if (!refresh) {
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
    }
    try {
      if (recharge) {
        final result =
            await SalePointAPI.superRechargeRecordList(params: entity);
        if (bloc.isClosed || request != bloc.recordsRequestVersion) return;
        if (result.code == 0 && result.data != null) {
          bloc.add(SuperRechargeRecordChanged(entity.page == 0
              ? result.data!
              : [...state.superRechargeRecordList, ...result.data!]));
        }
      } else {
        final result =
            await SalePointAPI.superCollectRecordList(params: entity);
        if (bloc.isClosed || request != bloc.recordsRequestVersion) return;
        if (result.code == 0 && result.data != null) {
          bloc.add(ChildRechargeRecordChanged(entity.page == 0
              ? result.data!
              : [...state.childRechargeRecordList, ...result.data!]));
        }
      }
    } catch (error) {
      Logger.write('$error');
    } finally {
      if (!refresh) EasyLoading.dismiss();
      if (!bloc.isClosed && request == bloc.recordsRequestVersion) {
        bloc.add(IsMoreChanged(false));
      }
    }
  }

  Future<void> postTransformation(int page, {bool refresh = false}) {
    final state = context.read<MyReportBloc>().state;
    final entity = PageOnlyRequestEntity()..page = page;
    return state.agent == 'shipment report'
        ? superRechargeRecord(entity, refresh: refresh)
        : childRechargeRecord(entity, refresh: refresh);
  }
}
