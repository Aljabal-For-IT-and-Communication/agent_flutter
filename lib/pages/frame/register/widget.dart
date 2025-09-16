// Removed unused: dart:math

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Removed unused: routes/names.dart
import 'package:app/common/values/colors.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import 'bloc.dart';
import 'logic.dart';

class BuildPresentationBtn extends StatelessWidget {
  const BuildPresentationBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: 46.h,
            margin: EdgeInsets.only(top: 10.h, left: 0.w, right: 0.w),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
            ),
            child: Center(
                child: Text(
              "Register".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
            ))),
        onTap: () {
          Logic(context: context).handleRegister();
        });
  }
}

class BuildInput extends StatelessWidget {
  final String name;
  final Function(String)? callFunc;
  final int? maxLength;
  const BuildInput(
      {Key? key, required this.name, required this.callFunc, this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            name,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Container(
          width: 330.w,
          height: 46.h,
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          decoration: BoxDecoration(
              color: AppColors.primaryFourElementText,
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
              border: Border.all(color: AppColors.primaryFourElementText)),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLength: maxLength,
            decoration: const InputDecoration(
              hintText: "",
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              hintStyle: TextStyle(
                color: AppColors.primaryThreeElementText,
              ),
            ),
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
            onChanged: callFunc,
            maxLines: 1,
            autocorrect: false,
            obscureText: false,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}

class BuildMachineNumberInput extends StatefulWidget {
  const BuildMachineNumberInput({Key? key}) : super(key: key);

  @override
  State<BuildMachineNumberInput> createState() =>
      _BuildMachineNumberInputState();
}

class _BuildMachineNumberInputState extends State<BuildMachineNumberInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final initial = context.read<RegisterBloc>().state.machineNumber;
    if (initial.isNotEmpty) {
      _controller.text = initial;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _scan() async {
    final String? res = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Scan',
        centerTitle: true,
        enableBackButton: true,
        backButtonIcon: Icon(Icons.arrow_back_ios),
      ),
      isShowFlashIcon: true,
      // delayMillis: 0, // optional
      // cameraFace: CameraFace.front, // optional
    );

    if (!mounted) return;

    if (res != null && res.isNotEmpty && res != "-1") {
      _controller.text = res;
      context.read<RegisterBloc>().add(MachineNumberChanged(res));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
          child: Text(
            "Machine Number".tr(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        SizedBox(
          width: 330.w,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 46.h,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryFourElementText,
                    borderRadius: BorderRadius.all(Radius.circular(8.w)),
                    border: Border.all(color: AppColors.primaryFourElementText),
                  ),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    maxLength: 13,
                    decoration: const InputDecoration(
                      hintText: "",
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintStyle: TextStyle(
                        color: AppColors.primaryThreeElementText,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.normal,
                      fontSize: 14.sp,
                    ),
                    onChanged: (value) {
                      context
                          .read<RegisterBloc>()
                          .add(MachineNumberChanged(value));
                    },
                    maxLines: 1,
                    autocorrect: false,
                    obscureText: false,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: _scan,
                child: Container(
                  height: 46.h,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.all(Radius.circular(8.w)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Scan".tr(),
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
