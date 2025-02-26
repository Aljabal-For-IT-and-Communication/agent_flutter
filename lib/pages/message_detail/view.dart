import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'widget.dart';


class MessageDetailPage extends StatefulWidget {
  const MessageDetailPage({Key? key}) : super(key: key);

  @override
  State<MessageDetailPage> createState() =>_MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      if (mounted) {
      //  var data = ModalRoute.of(context)?.settings.arguments as NotificationData;
       // context.read<MessageDetailBloc>().add(MessageDetailChanged(data));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments as NotificationData;
    return BlocBuilder<MessageDetailBloc, MessageDetailState>(builder: (context, state) {
      return Container(
        color: AppColors.primaryBackground,
        child: CustomScrollView(slivers: [
          SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 0.w,
                horizontal: 0.w,
              ),
              sliver: SliverToBoxAdapter(
                child:BuildPublicAppBar(title:"${data.title}"),
              )),
          SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 10.w,
                horizontal: 16.w,
              ),
              sliver: SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 5.w),
                  child: Text(
                    "${data.content}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primarySecondaryElementText,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),)
          ),
        ]),
      );
    });
  }

}

