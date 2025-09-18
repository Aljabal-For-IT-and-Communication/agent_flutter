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
  int? category;
  int? collectRecordId;
  String? createdAt;
  String? deletedAt;
  String? firstName;
  int? fromAgentId;
  int? id;
  String? phone;
  int? salesPointId;
  int? toAgentId;
  String? updatedAt;
  bool? validated;

  PendingCollectionData({
    this.amount,
    this.avatar,
    this.businessName,
    this.category,
    this.collectRecordId,
    this.createdAt,
    this.deletedAt,
    this.firstName,
    this.fromAgentId,
    this.id,
    this.phone,
    this.salesPointId,
    this.toAgentId,
    this.updatedAt,
    this.validated,
  });

  PendingCollectionData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    avatar = json['avatar'];
    businessName = json['business_name'];
    category = json['category'];
    collectRecordId = json['collect_record_id'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at']?.toString();
    firstName = json['first_name'];
    fromAgentId = json['from_agent_id'];
    id = json['id'];
    phone = json['phone'];
    salesPointId = json['sales_point_id'];
    toAgentId = json['to_agent_id'];
    updatedAt = json['updated_at'];
    validated = json['validated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['avatar'] = avatar;
    data['business_name'] = businessName;
    data['category'] = category;
    data['collect_record_id'] = collectRecordId;
    data['created_at'] = createdAt;
    data['deleted_at'] = deletedAt;
    data['first_name'] = firstName;
    data['from_agent_id'] = fromAgentId;
    data['id'] = id;
    data['phone'] = phone;
    data['sales_point_id'] = salesPointId;
    data['to_agent_id'] = toAgentId;
    data['updated_at'] = updatedAt;
    data['validated'] = validated;
    return data;
  }
}

class PendingRechargesResponseEntity {
  int? code;
  String? msg;
  List<PendingRechargeData>? data;

  PendingRechargesResponseEntity({this.code, this.msg, this.data});

  PendingRechargesResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <PendingRechargeData>[];
      json['data'].forEach((v) {
        data!.add(PendingRechargeData.fromJson(v));
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

class PendingRechargeData {
  String? amount;
  int? category;
  int? rechargeRecordId;
  int? collectRecordId;
  String? createdAt;
  String? deletedAt;
  int? fromAgentId;
  int? toAgentId;
  int? salesPointId;
  int? id;
  String? updatedAt;
  bool? validated;
  // Optional descriptive fields if backend returns them (keeping parity with collection data)
  String? firstName; // agent first name
  String? businessName; // sales point name
  String? phone;
  String? avatar;

  PendingRechargeData({
    this.amount,
    this.category,
    this.rechargeRecordId,
    this.collectRecordId,
    this.createdAt,
    this.deletedAt,
    this.fromAgentId,
    this.toAgentId,
    this.salesPointId,
    this.id,
    this.updatedAt,
    this.validated,
    this.firstName,
    this.businessName,
    this.phone,
    this.avatar,
  });

  PendingRechargeData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    category = json['category'];
    rechargeRecordId = json['recharge_record_id'];
    collectRecordId = json['collect_record_id'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at']?.toString();
    fromAgentId = json['from_agent_id'];
    toAgentId = json['to_agent_id'];
    salesPointId = json['sales_point_id'];
    id = json['id'];
    updatedAt = json['updated_at'];
    validated = json['validated'];
    firstName = json['first_name'];
    businessName = json['business_name'];
    phone = json['phone'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['category'] = category;
    data['recharge_record_id'] = rechargeRecordId;
    data['collect_record_id'] = collectRecordId;
    data['created_at'] = createdAt;
    data['deleted_at'] = deletedAt;
    data['from_agent_id'] = fromAgentId;
    data['to_agent_id'] = toAgentId;
    data['sales_point_id'] = salesPointId;
    data['id'] = id;
    data['updated_at'] = updatedAt;
    data['validated'] = validated;
    data['first_name'] = firstName;
    data['business_name'] = businessName;
    data['phone'] = phone;
    data['avatar'] = avatar;
    return data;
  }
}
