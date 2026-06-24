import 'package:app/common/apis/user.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/logger.dart';
import 'package:app/common/utils/i18n.dart';
import 'package:app/global.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'bloc.dart';

class Logic {
  final BuildContext context;
  Logic({
    required this.context,
  });

  // city(int? id, bool? all) async {
  //   try {
  //     IdRequestEntity idRequestEntity = IdRequestEntity();
  //     idRequestEntity.id = id;
  //     idRequestEntity.all = all;
  //     var result = await UserAPI.getCity(params: idRequestEntity);
  //     if (result.code == 0) {
  //       context.read<RegisterBloc>().add(CityListChanged(result.data!));
  //       context.read<RegisterBloc>().add(CityItemChanged(result.data!.first));
  //     }
  //   } catch (e) {
  //     Logger.write("${e}");
  //   }
  // }

  handleRegister() async {
    try {
      final state = context.read<RegisterBloc>().state;
      final user = Global.storageService.getUserProfile();
      String firstName = state.firstName;
      String middleName = state.middleName;
      String lastName = state.lastName;
      String businessName = state.businessName;
      String address = state.address;
      String phone = state.phone.replaceAll(RegExp(r'[^0-9]'), '');
      String password = state.password;
      String repassword = state.repassword;

      if (firstName.isEmpty) {
        toastInfo(msg: "First Name should not not be empty!".tr());
        return;
      }
      if (middleName.isEmpty) {
        toastInfo(msg: "Middle Name should not not be empty!".tr());
        return;
      }
      if (lastName.isEmpty) {
        toastInfo(msg: "Last Name should not not be empty!".tr());
        return;
      }
      if (businessName.isEmpty) {
        toastInfo(msg: "Business Name should not not be empty!".tr());
        return;
      }
      if (address.isEmpty) {
        toastInfo(msg: "Address should not not be empty!".tr());
        return;
      }
      if (phone.isEmpty) {
        toastInfo(msg: "Phone should not not be empty!".tr());
        return;
      }
      if (phone.length != 10) {
        toastInfo(msg: "Phone length is invalid!".tr());
        return;
      }
      if (password.isEmpty) {
        toastInfo(msg: "Password should not not be empty!".tr());
        return;
      }

      if (password.length < 6) {
        toastInfo(msg: "Password min length is 6!".tr());
        return;
      }
      if (password != repassword) {
        toastInfo(msg: "confirm Password not same!".tr());
        return;
      }
      if (state.machineNumber.isEmpty) {
        toastInfo(msg: "Machine Number should not be empty!".tr());
        return;
      }

      if (state.machineNumber.length != 13) {
        toastInfo(msg: "Machine Number must be 13 characters!".tr());
        return;
      }
      FocusManager.instance.primaryFocus?.unfocus();

      EasyLoading.show(
          indicator: CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);

      RegisterRequestEntity entity = RegisterRequestEntity();
      entity.password = state.password;
      entity.email = state.email;
      entity.firstName = state.firstName;
      entity.middleName = state.middleName;
      entity.lastName = state.lastName;
      entity.businessName = state.businessName;
      entity.city = user.city ?? 0;
      entity.region = user.region ?? 0;
      entity.address = state.address;
      entity.phone = phone;
      entity.latitude = "";
      entity.longitude = "";
      entity.machineNumber = state.machineNumber;
      FocusManager.instance.primaryFocus?.unfocus();

      var result = await UserAPI.register(params: entity);
      EasyLoading.dismiss();
      toastInfo(msg: trServerMessage("${result.msg}"));
      if (result.code == 0) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      EasyLoading.dismiss();
      toastInfo(msg: "${trServerMessage("Error")}: $e");
      Logger.write("${e}");
    }
  }
}
