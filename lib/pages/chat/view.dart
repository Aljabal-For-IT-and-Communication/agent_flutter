import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/utils/date.dart';
import 'package:app/pages/chat/bloc.dart';
import 'package:app/pages/chat/logic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  late Logic chatLogic;

  @override
  void initState() {
    super.initState();
    chatLogic = Logic(context: context);
    Future.delayed(Duration.zero, () {
      if (mounted) {
        chatLogic.init();
      }
    });
  }

  @override
  void dispose() {
    chatLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: _buildAppBar(state),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SafeArea(
                  child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.only(bottom: 70.h),
                        child: GestureDetector(
                          child: CustomScrollView(
                              reverse: true,
                              controller: chatLogic.myscrollController,
                              slivers: [
                                SliverPadding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 0.w,
                                    horizontal: 0.w,
                                  ),
                                  sliver: SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                    (content, index) {
                                      var item = state.msgcontentList[index];
                                      if (item.token ==
                                          chatLogic.userProfile.token) {
                                        return ChatRightItem(item);
                                      }
                                      return ChatLeftItem(item);
                                    },
                                    childCount: state.msgcontentList.length,
                                  )),
                                ),
                                SliverPadding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.w, horizontal: 0.w),
                                    sliver: SliverToBoxAdapter(
                                      child: state.isloading
                                          ? Align(
                                              alignment: Alignment.center,
                                              child:
                                                  new Text('loading...'.tr()),
                                            )
                                          : Container(),
                                    )),
                              ]),
                          onTap: () {
                            chatLogic.close_all_pop();
                          },
                        )),
                    Positioned(
                      bottom: 0.h,
                      child: Container(
                        width: 375.w,
                        constraints:
                            BoxConstraints(maxHeight: 170.h, minHeight: 70.h),
                        padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, bottom: 10.h, top: 10.h),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: 285.w,
                                constraints: BoxConstraints(
                                    maxHeight: 170.h, minHeight: 30.h),
                                padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBackground,
                                  border: Border.all(
                                      color: AppColors
                                          .primarySecondaryElementText),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Row(children: [
                                  Container(
                                    width: 235.w,
                                    constraints: BoxConstraints(
                                        maxHeight: 150.h, minHeight: 20.h),
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      controller: chatLogic.myinputController,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        hintText: "Message...".tr(),
                                        isDense: true,
                                        contentPadding: EdgeInsets.only(
                                            left: 10.w, top: 0, bottom: 0),
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
                                          color: AppColors
                                              .primarySecondaryElementText,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      width: 40.w,
                                      height: 40.h,
                                      child:
                                          Image.asset("assets/icons/photo.png"),
                                    ),
                                    onTap: () {
                                      _showPicker(context);
                                    },
                                  )
                                ])),
                            GestureDetector(
                                child: Container(
                                    height: 40.w,
                                    width: 40.w,
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryElement,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(1,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.w)),
                                    ),
                                    child: Image.asset(
                                      "assets/icons/send.png",
                                      color: AppColors.primaryBackground,
                                    )),
                                onTap: () {
                                  chatLogic.sendContent();
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )));
        });
  }

  AppBar _buildAppBar(ChatState state) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: false,
      title: Container(
        padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 0.w),
        child: Text(
          "${state.chatUserItem?.name}",
          overflow: TextOverflow.clip,
          maxLines: 1,
          style: TextStyle(
            fontFamily: 'Avenir',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget ChatLeftItem(Message item) {
    String type = "text";
    String? path = "";
    RegExp imgExp = RegExp(r"img\[(.*?)\]");
    var res = imgExp.hasMatch("${item.content}");
    if (res) {
      type = "img";
      path = "${item.content}"
          .replaceFirst(RegExp(r"img\["), "")
          .replaceFirst(RegExp(r"\]"), "");
    }
    return Container(
      padding:
          EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w, bottom: 10.h),
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
            child: item.avatar == null
                ? Image(
                    image: AssetImage('assets/images/account_header.png'),
                  )
                : CachedNetworkImage(
                    imageUrl: "${SERVER_IMG_URL}${item.avatar}",
                    height: 44.w,
                    width: 44.w,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(22.w)),
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
          ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: 250.w, //
                  minHeight: 40.w //
                  ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 0.w, top: 5.w),
                      padding: EdgeInsets.only(
                          top: 10.w, bottom: 10.w, left: 10.w, right: 10.w),
                      decoration: BoxDecoration(
                        color: AppColors.primarySecondaryBackground,
                        borderRadius: BorderRadius.all(Radius.circular(5.w)),
                      ),
                      child: type == "img"
                          ? ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 90.w),
                              child: GestureDetector(
                                child: CachedNetworkImage(
                                    imageUrl: "${SERVER_IMG_URL}${path}"),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.Photoimgview,
                                      arguments: {
                                        "url": "${SERVER_IMG_URL}${path}"
                                      });
                                },
                              ))
                          : Text("${item.content}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.primaryText,
                              )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: Text("${timeFormated(item.createdAt)}",
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: AppColors.primarySecondaryElementText)),
                    )
                  ])),
        ],
      ),
    );
  }

  Widget ChatRightItem(Message item) {
    String type = "text";
    String? path = "";
    RegExp imgExp = RegExp(r"img\[(.*?)\]");
    var res = imgExp.hasMatch("${item.content}");
    if (res) {
      type = "img";
      path = "${item.content}"
          .replaceFirst(RegExp(r"img\["), "")
          .replaceFirst(RegExp(r"\]"), "");
    }
    return Container(
      padding:
          EdgeInsets.only(top: 10.w, left: 20.w, right: 20.w, bottom: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: 250.w, //
                  minHeight: 40.w //
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 0.w, top: 0.w),
                      padding: EdgeInsets.only(
                          top: 10.w, bottom: 10.w, left: 10.w, right: 10.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                        borderRadius: BorderRadius.all(Radius.circular(5.w)),
                      ),
                      child: type == "img"
                          ? ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 90.w),
                              child: GestureDetector(
                                child: CachedNetworkImage(
                                    imageUrl: "${SERVER_IMG_URL}${path}"),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.Photoimgview,
                                      arguments: {
                                        "url": "${SERVER_IMG_URL}${path}"
                                      });
                                },
                              ))
                          : Text("${item.content}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.primaryElementText,
                              ))),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Text("${timeFormated(item.createdAt)}",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.primarySecondaryElementText)),
                  )
                ],
              )),
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: [
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        Logic(context: context).imgFromGallery();
                        Navigator.pop(context);
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      Logic(context: context).imgFromCamera();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
