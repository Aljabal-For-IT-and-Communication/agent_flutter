
import 'dart:convert';

import 'package:app/common/apis/user.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/routes.dart';
import 'package:app/common/utils/logger.dart';
import 'package:app/common/values/constant.dart';
import 'package:app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'bloc.dart';

class Logic{
  final BuildContext context;
  Logic({
    required this.context,
  });

  handleRegister() async{
    final state = context.read<RegisterBloc>().state;
    String firstName = state.firstName;
    String middleName = state.middleName;
    String lastName = state.lastName;
    String city = state.city;
    String area = state.area;
    String phone = state.phone;
    String emailAddress = state.email;
    String password = state.password;
    String repassword = state.repassword;

    if(firstName.isEmpty){
      toastInfo(msg: "firstName not empty!");
      return;
    }
    if(middleName.isEmpty){
      toastInfo(msg: "middleName not empty!");
      return;
    }
    if(lastName.isEmpty){
      toastInfo(msg: "lastName not empty!");
      return;
    }
    if(city.isEmpty){
      toastInfo(msg: "city not empty!");
      return;
    }
    if(area.isEmpty){
      toastInfo(msg: "area not empty!");
      return;
    }
    if(phone.isEmpty){
      toastInfo(msg: "phone not empty!");
      return;
    }

    if(password.isEmpty){
      toastInfo(msg: "Password not empty!");
      return;
    }
    if(password.length<6){
      toastInfo(msg: "Password min length is 6!");
      return;
    }
    if(password!=repassword){
      toastInfo(msg: "confirm Password not same!");
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();

    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    RegisterRequestEntity entity =  RegisterRequestEntity();
    entity.password = state.password;
    entity.email = state.email;
    entity.first_name = state.firstName;
    entity.middle_name = state.middleName;
    entity.last_name = state.lastName;
    entity.city = state.city;
    entity.area = state.area;
    entity.phone = state.phone;
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      var result = await UserAPI.register(params: entity);
      EasyLoading.dismiss();
      toastInfo(msg: "${result.msg}");
      if (result.code == 0) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      EasyLoading.dismiss();
      toastInfo(msg: 'internet error');
      Logger.write("${e}");
    }

  }


}