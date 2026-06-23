import 'package:dio/dio.dart';

class ShippingOperationResponseEntity {
  int? code;
  String? msg;
  List<ShippingOperationData>? data;

  ShippingOperationResponseEntity({this.code, this.msg, this.data});

  ShippingOperationResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <ShippingOperationData>[];
      json['data'].forEach((v) {
        data!.add(new ShippingOperationData.fromJson(v));
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

class ShippingOperationData {
  String? amount;
  String? rechargeTypeName;
  String? collectTypeName;
  String? businessName;
  String? createdAt;
  String? firstName;
  String? phone;
  String? profit;

  ShippingOperationData(
      {this.amount,
      this.rechargeTypeName,
      this.collectTypeName,
      this.businessName,
      this.createdAt,
      this.firstName,
      this.phone,
      this.profit});

  ShippingOperationData.fromJson(Map<String, dynamic> json) {
    amount = json['amount']?.toString();
    rechargeTypeName = json['recharge_type_name'];
    collectTypeName = json['collect_type_name'];
    businessName = json['business_name'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    phone = json['phone'];
    profit = json['profit']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['recharge_type_name'] = this.rechargeTypeName;
    data['collect_type_name'] = this.collectTypeName;
    data['business_name'] = this.businessName;
    data['created_at'] = this.createdAt;
    data['first_name'] = this.firstName;
    data['phone'] = this.phone;
    data['profit'] = this.profit;
    return data;
  }
}

class TransferBalanceRequestEntity {
  int? id;
  String? category;
  String? amount;
  String? converter;
  int? transferType;
  // Optional validation attachment (image or pdf)
  String? validationFilePath;
  String? validationFileName;

  TransferBalanceRequestEntity({
    this.id,
    this.category,
    this.amount,
    this.converter,
    this.transferType,
    this.validationFilePath,
    this.validationFileName,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "amount": amount,
        "converter": converter,
        "transfer_type": transferType,
      };

  // Build multipart form when validation file exists
  Future<dynamic> toRequestBody() async {
    if (validationFilePath != null && validationFilePath!.isNotEmpty) {
      return FormData.fromMap({
        "id": id,
        "category": category,
        "amount": amount,
        "converter": converter,
        "transfer_type": transferType,
        // Backend field name for file
        "file": await MultipartFile.fromFile(
          validationFilePath!,
          filename: validationFileName ?? 'attachment',
        ),
      });
    }
    return toJson();
  }
}

class TransferRecordListRequestEntity {
  int? id;
  String? category;
  int? page;

  TransferRecordListRequestEntity({
    this.id,
    this.category,
    this.page,
  });

  Map<String, dynamic> toJson() => {
        "category": category,
        "id": id,
        "page": page,
      };
}

class TransferCollectionRequestEntity {
  int? id;
  String? category;
  String? amount;
  int? transferType;
  String? validationFilePath;
  String? validationFileName;

  TransferCollectionRequestEntity({
    this.id,
    this.category,
    this.amount,
    this.transferType,
    this.validationFilePath,
    this.validationFileName,
  });

  Map<String, dynamic> toJson() => {
        "category": category,
        "amount": amount,
        "id": id,
        "transfer_type": transferType,
      };

  Future<dynamic> toRequestBody() async {
    if (validationFilePath != null && validationFilePath!.isNotEmpty) {
      return FormData.fromMap({
        "category": category,
        "amount": amount,
        "id": id,
        "transfer_type": transferType,
        "file": await MultipartFile.fromFile(
          validationFilePath!,
          filename: validationFileName ?? 'attachment',
        ),
      });
    }
    return toJson();
  }
}

class AgentRechargeRecordResponseEntity {
  int? code;
  String? msg;
  List<AgentRechargeRecordData>? data;

  AgentRechargeRecordResponseEntity({this.code, this.msg, this.data});

  AgentRechargeRecordResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <AgentRechargeRecordData>[];
      json['data'].forEach((v) {
        data!.add(new AgentRechargeRecordData.fromJson(v));
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

class AgentRechargeRecordData {
  String? amount;
  String? collectTypeName;
  String? rechargeTypeName;
  String? createdAt;
  String? firstName;
  int? id;
  String? phone;
  String? businessName;

  AgentRechargeRecordData(
      {this.amount,
      this.collectTypeName,
      this.rechargeTypeName,
      this.createdAt,
      this.firstName,
      this.id,
      this.phone,
      this.businessName});

  AgentRechargeRecordData.fromJson(Map<String, dynamic> json) {
    amount = json['amount']?.toString();
    collectTypeName = json['collect_type_name'];
    rechargeTypeName = json['recharge_type_name'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    id = json['id'];
    phone = json['phone'];
    businessName = json['business_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['collect_type_name'] = this.collectTypeName;
    data['recharge_type_name'] = this.rechargeTypeName;
    data['created_at'] = this.createdAt;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['phone'] = this.phone;
    return data;
  }
}

class SuperRechargeRecordResponseEntity {
  int? code;
  String? msg;
  List<SuperRechargeRecordData>? data;

  SuperRechargeRecordResponseEntity({this.code, this.msg, this.data});

  SuperRechargeRecordResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <SuperRechargeRecordData>[];
      json['data'].forEach((v) {
        data!.add(new SuperRechargeRecordData.fromJson(v));
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

class SuperRechargeRecordData {
  String? amount;
  String? createdAt;
  String? firstName;

  SuperRechargeRecordData({this.amount, this.createdAt, this.firstName});

  SuperRechargeRecordData.fromJson(Map<String, dynamic> json) {
    amount = json['amount']?.toString();
    createdAt = json['created_at'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['first_name'] = this.firstName;
    return data;
  }
}

class ChildRechargeRecordResponseEntity {
  int? code;
  String? msg;
  List<ChildRechargeRecordData>? data;

  ChildRechargeRecordResponseEntity({this.code, this.msg, this.data});

  ChildRechargeRecordResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <ChildRechargeRecordData>[];
      json['data'].forEach((v) {
        data!.add(new ChildRechargeRecordData.fromJson(v));
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

class ChildRechargeRecordData {
  String? amount;
  String? createdAt;
  String? firstName;

  ChildRechargeRecordData({this.amount, this.createdAt, this.firstName});

  ChildRechargeRecordData.fromJson(Map<String, dynamic> json) {
    amount = json['amount']?.toString();
    createdAt = json['created_at'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['first_name'] = this.firstName;
    return data;
  }
}

class AgentCollectRecordResponseEntity {
  int? code;
  String? msg;
  List<AgentCollectRecordData>? data;

  AgentCollectRecordResponseEntity({this.code, this.msg, this.data});

  AgentCollectRecordResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <AgentCollectRecordData>[];
      json['data'].forEach((v) {
        data!.add(new AgentCollectRecordData.fromJson(v));
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

class AgentCollectRecordData {
  String? amount;
  String? collectTypeName;
  String? rechargeTypeName;
  String? createdAt;
  String? firstName;
  String? businessName;
  int? id;
  String? phone;
  int? salesPointId;
  int? toAgentId;
  String? updatedAt;

  AgentCollectRecordData(
      {this.amount,
      this.collectTypeName,
      this.rechargeTypeName,
      this.createdAt,
      this.firstName,
      this.id,
      this.phone,
      this.salesPointId,
      this.toAgentId,
      this.businessName,
      this.updatedAt});

  AgentCollectRecordData.fromJson(Map<String, dynamic> json) {
    amount = json['amount']?.toString();
    collectTypeName = json['collect_type_name'];
    rechargeTypeName = json['recharge_type_name'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    id = json['id'];
    businessName = json['business_name'];
    phone = json['phone'];
    salesPointId = json['sales_point_id'];
    toAgentId = json['to_agent_id'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['collect_type_name'] = this.collectTypeName;
    data['recharge_type_name'] = this.rechargeTypeName;
    data['created_at'] = this.createdAt;
    data['first_name'] = this.firstName;
    data['business_name'] = this.businessName;
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['sales_point_id'] = this.salesPointId;
    data['to_agent_id'] = this.toAgentId;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TransferCollectionResponseEntity {
  int? code;
  String? msg;
  TransferCollectionData? data;

  TransferCollectionResponseEntity({this.code, this.msg, this.data});

  TransferCollectionResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null
        ? new TransferCollectionData.fromJson(json['data'])
        : null;
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

class TransferCollectionData {
  String? amount;
  String? createdAt;
  int? id;
  String? name;
  String? phone;
  String? collectTypeName;
  String? rechargeTypeName;

  TransferCollectionData(
      {this.amount,
      this.createdAt,
      this.id,
      this.name,
      this.phone,
      this.collectTypeName,
      this.rechargeTypeName});

  TransferCollectionData.fromJson(Map<String, dynamic> json) {
    amount = json['amount']?.toString();
    createdAt = json['created_at'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    collectTypeName = json['collect_type_name'];
    rechargeTypeName = json['recharge_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['collect_type_name'] = this.collectTypeName;
    data['recharge_type_name'] = this.rechargeTypeName;
    return data;
  }
}
