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
