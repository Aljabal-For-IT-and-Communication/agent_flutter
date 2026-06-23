class NotificationResponseEntity {
  int? code;
  String? msg;
  List<NotificationData>? data;

  NotificationResponseEntity({this.code, this.msg, this.data});

  NotificationResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v));
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

class NotificationData {
  String? content;
  String? createdAt;
  String? pic;
  String? title;

  NotificationData({this.content, this.createdAt, this.pic, this.title});

  NotificationData.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    createdAt = json['created_at'];
    pic = json['pic'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['pic'] = this.pic;
    data['title'] = this.title;
    return data;
  }
}
