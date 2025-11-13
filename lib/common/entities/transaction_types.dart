class CollectTypesResponseEntity {
  int? code;
  List<CollectTypeData>? data;
  String? msg;

  CollectTypesResponseEntity({this.code, this.data, this.msg});

  CollectTypesResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <CollectTypeData>[];
      json['data'].forEach((v) {
        data!.add(CollectTypeData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class CollectTypeData {
  int? id;
  String? typeName;
  bool? needsValidation;
  bool? available;
  String? filter;

  CollectTypeData({
    this.id,
    this.typeName,
    this.needsValidation,
    this.available,
    this.filter,
  });

  CollectTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    needsValidation = json['needs_validation'];
    available = json['available'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_name'] = this.typeName;
    data['needs_validation'] = this.needsValidation;
    data['available'] = this.available;
    data['filter'] = this.filter;
    return data;
  }
}

class RechargeTypesResponseEntity {
  int? code;
  List<RechargeTypeData>? data;
  String? msg;

  RechargeTypesResponseEntity({this.code, this.data, this.msg});

  RechargeTypesResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <RechargeTypeData>[];
      json['data'].forEach((v) {
        data!.add(RechargeTypeData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class RechargeTypeData {
  int? id;
  String? typeName;
  String? profit;
  bool? available;
  bool? autoCollect;
  bool? needsValidation;
  String? filter;

  RechargeTypeData({
    this.id,
    this.typeName,
    this.profit,
    this.available,
    this.autoCollect,
    this.needsValidation,
    this.filter,
  });

  RechargeTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    profit = json['profit']?.toString();
    available = json['available'];
    autoCollect = json['auto_collect'];
    needsValidation = json['needs_validation'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_name'] = this.typeName;
    data['profit'] = this.profit;
    data['available'] = this.available;
    data['auto_collect'] = this.autoCollect;
    data['needs_validation'] = this.needsValidation;
    data['filter'] = this.filter;
    return data;
  }
}
