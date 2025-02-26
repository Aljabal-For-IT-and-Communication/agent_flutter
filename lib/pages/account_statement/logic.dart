
import 'package:app/common/apis/sale_point.dart';
import 'package:app/common/entities/base.dart';
import 'package:app/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'bloc.dart';

class Logic{
  final BuildContext context;
  Logic({
    required this.context,
  });

  init(){
    DateRequestEntity entity = DateRequestEntity();
    entity.startDate = "";
    entity.endDate = "";
    accountStatement(entity);
  }

  accountStatement(DateRequestEntity entity) async {
    try {
      EasyLoading.show(
          indicator: CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      var result = await SalePointAPI.accountStatement(params: entity);
      if (result.code == 0) {
        context.read<AccountStatementBloc>().add(AccountStatementChanged(result.data!));
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Logger.write("${e}");
    }
  }



}