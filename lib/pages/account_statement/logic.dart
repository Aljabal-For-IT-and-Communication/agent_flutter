import 'package:app/common/apis/sale_point.dart';
import 'package:app/common/entities/base.dart';
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

  init() {
    DateRangeRequestEntity entity = DateRangeRequestEntity();
    entity.startDate = "";
    entity.endDate = "";
    accountStatement(entity);
  }

  Future<void> refresh() {
    final state = context.read<AccountStatementBloc>().state;
    final entity = DateRangeRequestEntity()
      ..startDate = state.startDate
      ..endDate = state.endDate;
    return accountStatement(entity, showLoading: false);
  }

  Future<void> accountStatement(DateRangeRequestEntity entity,
      {bool showLoading = true}) async {
    final bloc = context.read<AccountStatementBloc>();
    final request = ++bloc.recordsRequestVersion;
    try {
      if (showLoading)
        EasyLoading.show(
            indicator: CircularProgressIndicator(),
            maskType: EasyLoadingMaskType.clear,
            dismissOnTap: true);
      var result = await SalePointAPI.accountStatement(params: entity);
      if (bloc.isClosed || request != bloc.recordsRequestVersion) return;
      if (result.code == 0 && result.data != null) {
        bloc.add(AccountStatementChanged(result.data!));
      }
    } catch (e) {
      Logger.write("${e}");
    } finally {
      if (showLoading) EasyLoading.dismiss();
    }
  }
}
