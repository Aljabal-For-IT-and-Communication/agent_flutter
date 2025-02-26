import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/routes.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';
import 'logic.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        Logic(context: context).init();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ReportBloc, ReportState>(builder: (context, state) {
      return Container(
          color: AppColors.primaryBackground,
          child: CustomScrollView(slivers: [
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.w,
                  horizontal: 0.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: BuildAppBar(),
                )),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.h,
                  horizontal: 16.w,
                ),
                sliver:SliverToBoxAdapter(child: Column(children: [
                  BuildListItem(title:"Debit report".tr(),iconImage: "assets/icons/icon6.png",callFunc: (){
                    Navigator.of(context).pushNamed(AppRoutes.Debit);
                  },),
                  BuildListItem(title:"Shipments report".tr(),iconImage: "assets/icons/icon4.png",callFunc: (){
                    Navigator.of(context).pushNamed(AppRoutes.Shipment);
                  },),
                  BuildListItem(title:"Revenue report".tr(),iconImage: "assets/icons/icon3.png",callFunc: (){
                    Navigator.of(context).pushNamed(AppRoutes.Revenue);
                  },),
                  BuildListItem(title:"My report".tr(),iconImage: "assets/icons/icon1.png",callFunc: (){
                    Navigator.of(context).pushNamed(AppRoutes.MyReport);
                  },),
                ],),)),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 0.w,
                horizontal: 0.w,
              ),
              sliver: SliverToBoxAdapter(
                  child: SizedBox(
                height: 16.h,
              )),
            ),
          ]));
    });
  }
}
