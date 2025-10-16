
import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/services/socketchannel.dart';
import 'package:app/common/services/sql_db.dart';
import 'package:app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class ChatUserLogic with WidgetsBindingObserver {
  final BuildContext context;
  var userItem = Global.storageService.getUserProfile();

  ChatUserLogic({
    required this.context,
  });


  void init(){
    asyncLoadAllData();
    Global.eventBus.on<WebSocketEvent>().listen((event) {
      print(event.message);
      asyncLoadAllData();
    });
  }

  goChat(ChatUserItem item) async{
    if (item.token != null) {
      var result = await Navigator.of(context).pushNamed(AppRoutes.Chat,arguments: item);
     // if (result == "finish") {
        asyncLoadAllData();
     // }
    }
  }
  // 拉取数据
  asyncLoadAllData() async {
    SqlDbService sqlDbService = await SqlDbService().init();
    var result = await sqlDbService.queryAllRows();
    List<ChatUserItem> chatUserList = [];
    for (var item in result) {
      ChatUserItem chatUser = ChatUserItem();
      chatUser.token = item["token"];
      chatUser.cid = item["cid"];
      chatUser.name = item["name"];
      chatUser.avatar = item["avatar"];
      chatUser.lastMsg= item["last_msg"];
      chatUser.lastTime= item["last_time"];
      chatUser.msgNum= item["msg_num"];
      chatUserList.add(chatUser);
    }
    context.read<ChatUserBloc>().add(ChatListChanged(chatUserList));
  }
}
