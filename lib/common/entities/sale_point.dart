class SalePointResponseEntity {
  int? code;
  String? msg;
  List<SalePointData>? data;

  SalePointResponseEntity({this.code, this.msg, this.data});

  SalePointResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <SalePointData>[];
      json['data'].forEach((v) {
        data!.add(new SalePointData.fromJson(v));
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

class SalePointData {
  String? avatar;
  String? balance;
  String? businessName;
  String? address;
  int? cid;
  String? machineNumber;
  String? firstName;
  int? id;
  String? indebtedness;
  String? lastName;
  String? middleName;
  String? phone;
  String? token;
  String? lastLogin;
  String? lastCollectAt;
  String? lastRechargeAt;
  int? region;
  int? city;
  int? status;

  SalePointData(
      {this.avatar,
      this.balance,
      this.businessName,
      this.address,
      this.cid,
      this.machineNumber,
      this.firstName,
      this.id,
      this.indebtedness,
      this.lastName,
      this.middleName,
      this.phone,
      this.token,
      this.lastLogin,
      this.lastCollectAt,
      this.lastRechargeAt,
      this.region,
      this.city,
      this.status});

  SalePointData.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    balance = json['balance']?.toString();
    machineNumber = json['machine_number'];
    businessName = json['business_name'];
    address = json['address'];
    cid = json['cid'];
    firstName = json['first_name'];
    id = json['id'];
    indebtedness = json['indebtedness']?.toString();
    lastName = json['last_name'];
    middleName = json['middle_name'];
    phone = json['phone'];
    token = json['token'];
    lastLogin = json['last_login'];
    lastCollectAt = (json['last_collect_at'] ??
            json['lastCollectAt'] ??
            json['LastCollectAt'])
        ?.toString();
    lastRechargeAt = (json['last_recharge_at'] ??
            json['lastRechargeAt'] ??
            json['LastRechargeAt'])
        ?.toString();
    region = json['region'];
    city = json['city'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['balance'] = this.balance;
    data['business_name'] = this.businessName;
    data['address'] = this.address;
    data['machine_number'] = this.machineNumber;
    data['cid'] = this.cid;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['indebtedness'] = this.indebtedness;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['phone'] = this.phone;
    data['token'] = this.token;
    data['last_login'] = this.lastLogin;
    data['last_collect_at'] = this.lastCollectAt;
    data['last_recharge_at'] = this.lastRechargeAt;
    data['region'] = this.region;
    data['city'] = this.city;
    data['status'] = this.status;
    return data;
  }
}

class AccountStatementResponseEntity {
  int? code;
  String? msg;
  AccountStatementData? data;

  AccountStatementResponseEntity({this.code, this.msg, this.data});

  AccountStatementResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null
        ? new AccountStatementData.fromJson(json['data'])
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

class AccountStatementData {
  String? currentBalance;
  String? moneyOwedYou;
  String? moneyYouOwe;
  String? paidMoney;
  String? sendBalance;

  AccountStatementData(
      {this.currentBalance,
      this.moneyOwedYou,
      this.moneyYouOwe,
      this.paidMoney,
      this.sendBalance});

  AccountStatementData.fromJson(Map<String, dynamic> json) {
    currentBalance = json['current_balance']?.toString();
    moneyOwedYou = json['money_owed_you']?.toString();
    moneyYouOwe = json['money_you_owe']?.toString();
    paidMoney = json['paid_money']?.toString();
    sendBalance = json['send_balance']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_balance'] = this.currentBalance;
    data['money_owed_you'] = this.moneyOwedYou;
    data['money_you_owe'] = this.moneyYouOwe;
    data['paid_money'] = this.paidMoney;
    data['send_balance'] = this.sendBalance;
    return data;
  }
}

// Sale Point update requests
class SalePointDataUpdateRequestEntity {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? businessName;
  String? machineNumber;
  String? address;
  String? avatar;

  SalePointDataUpdateRequestEntity({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.businessName,
    this.machineNumber,
    this.address,
    this.avatar,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "business_name": businessName,
        "machine_number": machineNumber,
        "address": address,
        "avatar": avatar,
      };
}

class SalePointStatusUpdateRequestEntity {
  int? id;
  int? status;

  SalePointStatusUpdateRequestEntity({
    this.id,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}

class SalePointIdRequestEntity {
  int? salePointId;

  SalePointIdRequestEntity({
    this.salePointId,
  });

  Map<String, dynamic> toJson() => {
        "sale_point_id": salePointId,
      };
}

class WalletPasswordResponseEntity {
  int? code;
  String? msg;
  String? walletPassword;

  WalletPasswordResponseEntity({
    this.code,
    this.msg,
    this.walletPassword,
  });

  factory WalletPasswordResponseEntity.fromJson(Map<String, dynamic> json) =>
      WalletPasswordResponseEntity(
        code: json["code"],
        msg: json["msg"],
        walletPassword: json["wallet_password"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "wallet_password": walletPassword,
      };
}

class SalePointPasswordResponseEntity {
  int? code;
  String? msg;
  String? newPassword;

  SalePointPasswordResponseEntity({
    this.code,
    this.msg,
    this.newPassword,
  });

  factory SalePointPasswordResponseEntity.fromJson(Map<String, dynamic> json) =>
      SalePointPasswordResponseEntity(
        code: json["code"],
        msg: json["msg"],
        newPassword: json["new_password"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "new_password": newPassword,
      };
}
