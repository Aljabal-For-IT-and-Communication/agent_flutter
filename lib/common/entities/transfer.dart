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
  String? avatar;
  String? rechargeTypeName;
  String? collectTypeName;
  String? businessName;
  String? createdAt;
  String? deletedAt;
  String? firstName;
  int? fromAgentId;
  int? id;
  String? phone;
  String? profit;
  int? salesPointId;
  int? toAgentId;
  String? updatedAt;

  ShippingOperationData(
      {this.amount,
      this.avatar,
      this.rechargeTypeName,
      this.collectTypeName,
      this.businessName,
      this.createdAt,
      this.deletedAt,
      this.firstName,
      this.fromAgentId,
      this.id,
      this.phone,
      this.profit,
      this.salesPointId,
      this.toAgentId,
      this.updatedAt});

  ShippingOperationData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    avatar = json['avatar'];
    rechargeTypeName = json['recharge_type_name'];
    collectTypeName = json['collect_type_name'];
    businessName = json['business_name'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    firstName = json['first_name'];
    fromAgentId = json['from_agent_id'];
    id = json['id'];
    phone = json['phone'];
    profit = json['profit'];
    salesPointId = json['sales_point_id'];
    toAgentId = json['to_agent_id'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['avatar'] = this.avatar;
    data['recharge_type_name'] = this.rechargeTypeName;
    data['collect_type_name'] = this.collectTypeName;
    data['business_name'] = this.businessName;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    data['first_name'] = this.firstName;
    data['from_agent_id'] = this.fromAgentId;
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['profit'] = this.profit;
    data['sales_point_id'] = this.salesPointId;
    data['to_agent_id'] = this.toAgentId;
    data['updated_at'] = this.updatedAt;
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

class TransferRequestEntity {
  int? id;
  String? Category;
  String? Amount;
  int? page;
  int? transferType;
  // Optional validation attachment (image or pdf)
  String? validationFilePath;
  String? validationFileName;

  TransferRequestEntity({
    this.id,
    this.Category,
    this.Amount,
    this.page,
    this.transferType,
    this.validationFilePath,
    this.validationFileName,
  });

  Map<String, dynamic> toJson() => {
        "category": Category,
        "amount": Amount,
        "id": id,
        "page": page,
        "transfer_type": transferType,
      };

  // Build multipart form when validation file exists
  Future<dynamic> toRequestBody() async {
    if (validationFilePath != null && validationFilePath!.isNotEmpty) {
      return FormData.fromMap({
        "category": Category,
        "amount": Amount,
        "id": id,
        "page": page,
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
  String? avatar;
  String? collectTypeName;
  String? rechargeTypeName;
  String? createdAt;
  String? deletedAt;
  String? firstName;
  int? fromAgentId;
  int? id;
  String? phone;
  String? profit;
  int? salesPointId;
  int? toAgentId;
  String? updatedAt;
  String? businessName;

  AgentRechargeRecordData(
      {this.amount,
      this.avatar,
      this.collectTypeName,
      this.rechargeTypeName,
      this.createdAt,
      this.deletedAt,
      this.firstName,
      this.fromAgentId,
      this.id,
      this.phone,
      this.profit,
      this.salesPointId,
      this.toAgentId,
      this.businessName,
      this.updatedAt});

  AgentRechargeRecordData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    avatar = json['avatar'];
    collectTypeName = json['collect_type_name'];
    rechargeTypeName = json['recharge_type_name'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    firstName = json['first_name'];
    fromAgentId = json['from_agent_id'];
    id = json['id'];
    phone = json['phone'];
    profit = json['profit'];
    businessName = json['business_name'];
    salesPointId = json['sales_point_id'];
    toAgentId = json['to_agent_id'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['avatar'] = this.avatar;
    data['collect_type_name'] = this.collectTypeName;
    data['recharge_type_name'] = this.rechargeTypeName;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    data['first_name'] = this.firstName;
    data['from_agent_id'] = this.fromAgentId;
    data['business_name'] = this.businessName;
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['profit'] = this.profit;
    data['sales_point_id'] = this.salesPointId;
    data['to_agent_id'] = this.toAgentId;
    data['updated_at'] = this.updatedAt;
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
  String? deletedAt;
  String? firstName;
  int? fromAgentId;
  int? id;
  String? profit;
  int? salesPointId;
  int? toAgentId;
  String? updatedAt;

  SuperRechargeRecordData(
      {this.amount,
      this.createdAt,
      this.deletedAt,
      this.firstName,
      this.fromAgentId,
      this.id,
      this.profit,
      this.salesPointId,
      this.toAgentId,
      this.updatedAt});

  SuperRechargeRecordData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    firstName = json['first_name'];
    fromAgentId = json['from_agent_id'];
    id = json['id'];
    profit = json['profit'];
    salesPointId = json['sales_point_id'];
    toAgentId = json['to_agent_id'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    data['first_name'] = this.firstName;
    data['from_agent_id'] = this.fromAgentId;
    data['id'] = this.id;
    data['profit'] = this.profit;
    data['sales_point_id'] = this.salesPointId;
    data['to_agent_id'] = this.toAgentId;
    data['updated_at'] = this.updatedAt;
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
  int? category;
  String? createdAt;
  String? deletedAt;
  String? firstName;
  int? fromAgentId;
  int? id;
  int? salesPointId;
  int? toAgentId;
  String? updatedAt;

  ChildRechargeRecordData(
      {this.amount,
      this.category,
      this.createdAt,
      this.deletedAt,
      this.firstName,
      this.fromAgentId,
      this.id,
      this.salesPointId,
      this.toAgentId,
      this.updatedAt});

  ChildRechargeRecordData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    category = json['category'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    firstName = json['first_name'];
    fromAgentId = json['from_agent_id'];
    id = json['id'];
    salesPointId = json['sales_point_id'];
    toAgentId = json['to_agent_id'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['category'] = this.category;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    data['first_name'] = this.firstName;
    data['from_agent_id'] = this.fromAgentId;
    data['id'] = this.id;
    data['sales_point_id'] = this.salesPointId;
    data['to_agent_id'] = this.toAgentId;
    data['updated_at'] = this.updatedAt;
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
  String? avatar;
  String? collectTypeName;
  String? rechargeTypeName;
  int? category;
  String? createdAt;
  String? deletedAt;
  String? firstName;
  int? fromAgentId;
  String? businessName;
  int? id;
  String? phone;
  int? salesPointId;
  int? toAgentId;
  String? updatedAt;

  AgentCollectRecordData(
      {this.amount,
      this.avatar,
      this.collectTypeName,
      this.rechargeTypeName,
      this.category,
      this.createdAt,
      this.deletedAt,
      this.firstName,
      this.fromAgentId,
      this.id,
      this.phone,
      this.salesPointId,
      this.toAgentId,
      this.businessName,
      this.updatedAt});

  AgentCollectRecordData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    avatar = json['avatar'];
    collectTypeName = json['collect_type_name'];
    rechargeTypeName = json['recharge_type_name'];
    category = json['category'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    firstName = json['first_name'];
    fromAgentId = json['from_agent_id'];
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
    data['avatar'] = this.avatar;
    data['collect_type_name'] = this.collectTypeName;
    data['recharge_type_name'] = this.rechargeTypeName;
    data['category'] = this.category;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    data['first_name'] = this.firstName;
    data['from_agent_id'] = this.fromAgentId;
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
    amount = json['amount'];
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
