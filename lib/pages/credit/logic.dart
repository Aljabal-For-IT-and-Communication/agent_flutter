
import 'package:app/common/apis/sale_point.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:app/global.dart';
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
    var userProfile = Global.storageService.getUserProfile();
    context.read<CreditBloc>().add(UserProfileChanged(userProfile));
  }


  postTransformation() async{
    final state = context.read<CreditBloc>().state;

    if(state.Amount.isEmpty){
      toastInfo(msg: "Amount not empty!");
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);

    AmountRequestEntity entity =  AmountRequestEntity();
    entity.amount = state.Amount;
    try {
      var result = await SalePointAPI.requestCredit(params: entity);
      EasyLoading.dismiss();
      toastInfo(msg: "${result.msg}");
      if (result.code == 0) {
        Navigator.pop(context);
      }
    } catch (e) {
      EasyLoading.dismiss();
      toastInfo(msg: 'internet error');
      Logger.write("${e}");
    }
  }



}