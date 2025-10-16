class ChatRequestEntity {
  String? toToken;
  String? content;
  int? toCid;

  ChatRequestEntity({
    this.toToken,
    this.toCid,
    this.content,
  });

  Map<String, dynamic> toJson() => {
        "to_cid": toCid,
        "to_token": toToken,
        "content": content,
      };
}

class SendMessageResponseEntity {
  int? code;
  String? msg;
  Message? data;

  SendMessageResponseEntity({this.code, this.msg, this.data});

  SendMessageResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Message.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MessageResponseEntity {
  int? code;
  String? msg;
  List<Message>? data;

  MessageResponseEntity({this.code, this.msg, this.data});

  MessageResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Message>[];
      json['data'].forEach((v) {
        data!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? avatar;
  int? cid;
  String? content;
  String? createdAt;
  String? deletedAt;
  int? id;
  String? name;
  int? toCid;
  String? toToken;
  String? token;
  String? updatedAt;

  Message(
      {this.avatar,
      this.cid,
      this.content,
      this.createdAt,
      this.deletedAt,
      this.id,
      this.name,
      this.toCid,
      this.toToken,
      this.token,
      this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    cid = json['cid'];
    content = json['content'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    id = json['id'];
    name = json['name'];
    toCid = json['to_cid'];
    toToken = json['to_token'];
    token = json['token'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['cid'] = this.cid;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    data['id'] = this.id;
    data['name'] = this.name;
    data['to_cid'] = this.toCid;
    data['to_token'] = this.toToken;
    data['token'] = this.token;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ChatUserItem {
  String? avatar;
  String? lastMsg;
  String? lastTime;
  String? name;
  String? token;
  int? cid;
  int? msgNum;

  ChatUserItem(
      {this.avatar,
      this.cid,
      this.lastMsg,
      this.lastTime,
      this.name,
      this.msgNum,
      this.token});

  ChatUserItem.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    cid = json['cid'];
    lastMsg = json['last_msg'];
    lastTime = json['last_time'];
    name = json['name'];
    token = json['token'];
    msgNum = json['msg_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['cid'] = this.cid;
    data['last_msg'] = this.lastMsg;
    data['last_time'] = this.lastTime;
    data['name'] = this.name;
    data['token'] = this.token;
    data['msg_num'] = this.msgNum;
    return data;
  }
}
