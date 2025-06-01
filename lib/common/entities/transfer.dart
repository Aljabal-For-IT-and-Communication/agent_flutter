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

  TransferBalanceRequestEntity({
    this.id,
    this.category,
    this.amount,
    this.converter,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "amount": amount,
    "converter": converter,
  };
}

class TransferRequestEntity {
  int? id;
  String? Category;
  String? Amount;
  int? page;

  TransferRequestEntity({
    this.id,
    this.Category,
    this.Amount,
    this.page,
  });

  Map<String, dynamic> toJson() => {
    "category": Category,
    "amount": Amount,
    "id": id,
    "page": page,
  };
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
    data = json['data'] != null ? new TransferCollectionData.fromJson(json['data']) : null;
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

  TransferCollectionData({this.amount, this.createdAt, this.id, this.name, this.phone});

  TransferCollectionData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    createdAt = json['created_at'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}
