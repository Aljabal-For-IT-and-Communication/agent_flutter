import 'package:app/common/routes/routes.dart';
import 'package:app/common/values/values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';
import 'logic.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
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
    return BlocBuilder<CollectionBloc, CollectionState>(builder: (context, state) {
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
                  BuildListItem(title:"Collections".tr(),iconImage: "assets/icons/icon6.png",callFunc: (){
                     Navigator.of(context).pushNamed(AppRoutes.CollectionItem);
                  },),
                  BuildListItem(title:"Point of sale collections".tr(),iconImage: "assets/icons/icon4.png",callFunc: (){
                     Navigator.of(context).pushNamed(AppRoutes.CollectionSalePoint);
                  },),
                  BuildListItem(title:"What has been collected?".tr(),iconImage: "assets/icons/icon3.png",callFunc: (){
                     Navigator.of(context).pushNamed(AppRoutes.CollectionWhat);
                  },),
                ],),)),
          ]));
    });
  }
}
