class PendingCollectionsResponseEntity {
  int? code;
  String? msg;
  List<PendingCollectionData>? data;

  PendingCollectionsResponseEntity({this.code, this.msg, this.data});

  PendingCollectionsResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <PendingCollectionData>[];
      json['data'].forEach((v) {
        data!.add(PendingCollectionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingCollectionData {
  String? amount;
  String? avatar;
  String? businessName;
  String? createdAt;
  String? firstName;
  String? phone;
  bool? validated;

  PendingCollectionData({
    this.amount,
    this.avatar,
    this.businessName,
    this.createdAt,
    this.firstName,
    this.phone,
    this.validated,
  });

  PendingCollectionData.fromJson(Map<String, dynamic> json) {
    amount = json['amount']?.toString();
    avatar = json['avatar'];
    businessName = json['business_name'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    phone = json['phone'];
    validated = json['validated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['avatar'] = avatar;
    data['business_name'] = businessName;
    data['created_at'] = createdAt;
    data['first_name'] = firstName;
    data['phone'] = phone;
    data['validated'] = validated;
    return data;
  }
}

class PendingTransactionsResponseEntity {
  int? code;
  String? msg;
  List<PendingTransactionData>? data;

  PendingTransactionsResponseEntity({this.code, this.msg, this.data});

  PendingTransactionsResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <PendingTransactionData>[];
      json['data'].forEach((v) {
        data!.add(PendingTransactionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingTransactionData {
  String? amount;
  String? createdAt;
  bool? validated;
  bool? isRecharge;
  String? firstName;
  String? businessName;
  String? phone;
  String? avatar;

  PendingTransactionData({
    this.amount,
    this.createdAt,
    this.validated,
    this.firstName,
    this.businessName,
    this.phone,
    this.avatar,
    this.isRecharge,
  });

  PendingTransactionData.fromJson(Map<String, dynamic> json) {
    amount = json['amount']?.toString();
    createdAt = json['created_at'];
    validated = json['validated'];
    firstName = json['first_name'];
    businessName = json['business_name'];
    phone = json['phone'];
    avatar = json['avatar'];
    isRecharge = json['is_recharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['validated'] = validated;
    data['first_name'] = firstName;
    data['business_name'] = businessName;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['is_recharge'] = isRecharge;
    return data;
  }
}
