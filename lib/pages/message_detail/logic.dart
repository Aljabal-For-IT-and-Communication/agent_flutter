import 'dart:convert';
import 'package:app/common/apis/apis.dart';
import 'package:app/common/apis/home.dart';
import 'package:app/common/entities/base.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/utils/logger.dart';
import 'package:app/common/values/constant.dart';
import 'package:app/common/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'bloc.dart';

class Logic{
  final BuildContext context;
  Logic({
    required this.context,
  });

}