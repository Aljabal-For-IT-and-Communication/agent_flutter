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
  int? category;
  String? content;
  String? createdAt;
  String? deletedAt;
  int? id;
  String? pic;
  String? title;
  String? updatedAt;
  int? userId;

  NotificationData(
      {this.category,
        this.content,
        this.createdAt,
        this.deletedAt,
        this.id,
        this.pic,
        this.title,
        this.updatedAt,
        this.userId});

  NotificationData.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    content = json['content'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    id = json['id'];
    pic = json['pic'];
    title = json['title'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    data['id'] = this.id;
    data['pic'] = this.pic;
    data['title'] = this.title;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    return data;
  }
}