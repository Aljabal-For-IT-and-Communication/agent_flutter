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

  CollectTypeData({
    this.id,
    this.typeName,
    this.needsValidation,
  });

  CollectTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    needsValidation = json['needs_validation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_name'] = this.typeName;
    data['needs_validation'] = this.needsValidation;
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
  bool? needsValidation;

  RechargeTypeData({
    this.id,
    this.typeName,
    this.profit,
    this.needsValidation,
  });

  RechargeTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    profit = json['profit']?.toString();
    needsValidation = json['needs_validation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_name'] = this.typeName;
    data['profit'] = this.profit;
    data['needs_validation'] = this.needsValidation;
    return data;
  }
}
