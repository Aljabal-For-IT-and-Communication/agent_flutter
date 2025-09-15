class BaseResponseEntity {
  int? code;
  String? msg;
  String? data;

  BaseResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory BaseResponseEntity.fromJson(Map<String, dynamic> json) =>
      BaseResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "counts": code,
        "msg": msg,
        "items": data,
      };
}

class IdRequestEntity {
  int? id;

  IdRequestEntity({
    this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class TitleRequestEntity {
  String? title;

  TitleRequestEntity({
    this.title,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}

class PageRequestEntity {
  String? title;
  int? page;

  PageRequestEntity({
    this.title,
    this.page,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "page": page,
      };
}

class AmountRequestEntity {
  String? amount;

  AmountRequestEntity({
    this.amount,
  });

  Map<String, dynamic> toJson() => {
        "amount": amount,
      };
}

class DateRequestEntity {
  String? startDate;
  String? endDate;
  int? page;

  DateRequestEntity({
    this.startDate,
    this.endDate,
    this.page,
  });

  Map<String, dynamic> toJson() => {
        "start_date": startDate,
        "end_date": endDate,
        "page": page,
      };
}

class BaseData {
  int? id;
  String? image;
  String? name;

  BaseData({
    this.id,
    this.image,
    this.name,
  });

  BaseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}

class BindFcmTokenRequestEntity {
  String? fcmtoken;

  BindFcmTokenRequestEntity({
    this.fcmtoken,
  });

  Map<String, dynamic> toJson() => {
        "fcmtoken": fcmtoken,
      };
}

class TokenRequestEntity {
  String? token;

  TokenRequestEntity({
    this.token,
  });

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
