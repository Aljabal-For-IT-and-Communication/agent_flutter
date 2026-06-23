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

class PageOnlyRequestEntity {
  int? page;

  PageOnlyRequestEntity({
    this.page,
  });

  Map<String, dynamic> toJson() => {
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

class DateRangeRequestEntity {
  String? startDate;
  String? endDate;

  DateRangeRequestEntity({
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toJson() => {
        "start_date": startDate,
        "end_date": endDate,
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

class TokenRequestEntity {
  String? token;

  TokenRequestEntity({
    this.token,
  });

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
