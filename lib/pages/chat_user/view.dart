
import 'package:app/common/entities/chat.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/widgets/message_badge.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:app/common/utils/utils.dart';
import 'package:app/pages/chat_user/bloc.dart';
import 'package:app/pages/chat_user/logic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widget.dart';

class ChatUserPage extends StatefulWidget {
  const ChatUserPage({super.key});

  @override
  State<ChatUserPage> createState() => _ChatUserPage();
}

class _ChatUserPage extends State<ChatUserPage>{

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      if(mounted){
        ChatUserLogic(context: context).init();
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatUserBloc, ChatUserState>(
        listener: (context, state) {},
    builder: (context, state) {
          return Container( color: AppColors.primaryBackground,
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
                vertical: 0.w,
                horizontal: 16.w,
              ),
              sliver: state.chatList.length == 0
                  ? SliverToBoxAdapter(
                child: Container(
                  width: 375.w,
                  height: 512.h,
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Center(
                    child: Text(
                      'No Chat User!'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.primarySecondaryElementText,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              )
                  : SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (content, index) {
                      var item = state.chatList[index];
                      return chatListItem(item);
                    },
                    childCount: state.chatList.length,
                  )),
            )
          ]),);
  }
    );}

  Widget chatListItem(ChatUserItem item) {
    RegExp imgExp =  RegExp(r"img\[(.*?)\]");
    var res = imgExp.hasMatch("${item.lastMsg}");
    if(res){
      item.lastMsg = "[image]";
    }
    return Container(
      padding: EdgeInsets.only(top: 10.h, left: 0.w, right: 0.w, bottom: 10.h),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: AppColors.primaryFourElementText))),
      child: InkWell(
          onTap: () {
            ChatUserLogic(context: context).goChat(item);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 44.w,
                height: 44.w,
                margin: EdgeInsets.only(top: 0.h, left: 0.w, right: 10.w),
                decoration: BoxDecoration(
                  color: AppColors.primarySecondaryBackground,
                  borderRadius: BorderRadius.all(Radius.circular(22.w)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: CachedNetworkImage(
                  imageUrl: "${SERVER_IMG_URL}${item.avatar}",
                  height: 44.w,
                  width: 44.w,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(22.w)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill
                        // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image(
                    image: AssetImage('assets/images/account_header.png'),
                  ),
                ),
              ),
              // 右侧
              Container(
                padding: EdgeInsets.only(
                    top: 0.w, left: 0.w, right: 0.w, bottom: 0.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // center
                    SizedBox(
                        width: 200.w,
                        height: 44.w,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${item.name}",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "${item.lastMsg}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.primarySecondaryElementText,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ])),
                    Container(
                      width: 85.w,
                      height: 44.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 85.w,
                            child: Text(
                              "${timeFormated(item.lastTime)}",
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                fontWeight: FontWeight.normal,
                                color: AppColors.primaryThreeElementText,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            child: MessageBadge(unreadCount: item.msgNum??0,),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }


}



