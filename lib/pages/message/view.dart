import 'package:app/common/entities/entities.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:app/pages/message/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'logic.dart';


class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  ScrollController scrollController = ScrollController();
  var lastPostCalled;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      if(mounted){
        Logic(context: context).message();
      }
    });
    scrollController.addListener(() {
      if ((scrollController.offset + 10) > scrollController.position.maxScrollExtent) {
        if (lastPostCalled == null || DateTime.now().difference(lastPostCalled!) > Duration(seconds: 2)) {
          setState(() {
            lastPostCalled = DateTime.now();
          });
          context.read<MessageBloc>().add(IsMoreChanged(true));
          Logic(context: context).message();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          return Container(
            color: AppColors.primaryBackground,
            child: CustomScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: [
              SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.w,
                    horizontal: 0.w,
                  ),
                  sliver: SliverToBoxAdapter(
                    child:BuildPublicAppBar(title:"Notication".tr()),
                  )),
              SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.w,
                    horizontal: 16.w,
                  ),
                  sliver: SliverList(delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          NotificationData item = state.message.elementAt(index);
                      return BuildListItem(item: item);
                    },
                    childCount: state.message.length,
                  ),
                  )
              ),
                  buildBottomLoading(state.isMore),
            ]),
          );
        });
  }

}

