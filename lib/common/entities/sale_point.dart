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
  int? cid;
  String? machineNumber;
  String? firstName;
  int? id;
  String? indebtedness;
  String? lastName;
  String? middleName;
  String? phone;
  String? token;
  String? createdAt;
  String? lastLogin;
  int? status;

  SalePointData(
      {this.avatar,
      this.balance,
      this.businessName,
      this.cid,
      this.machineNumber,
      this.firstName,
      this.id,
      this.indebtedness,
      this.lastName,
      this.middleName,
      this.phone,
      this.token,
      this.createdAt,
      this.lastLogin,
      this.status});

  SalePointData.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    balance = json['balance'];
    machineNumber = json['machine_number'];
    businessName = json['business_name'];
    cid = json['cid'];
    firstName = json['first_name'];
    id = json['id'];
    indebtedness = json['indebtedness'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    phone = json['phone'];
    token = json['token'];
    createdAt = json['created_at'];
    lastLogin = json['last_login'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['balance'] = this.balance;
    data['business_name'] = this.businessName;
    data['machine_number'] = this.machineNumber;
    data['cid'] = this.cid;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['indebtedness'] = this.indebtedness;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['phone'] = this.phone;
    data['token'] = this.token;
    data['created_at'] = this.createdAt;
    data['last_login'] = this.lastLogin;
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
  String? receiviedTransferBalance;
  String? sendBalance;

  AccountStatementData(
      {this.currentBalance,
      this.moneyOwedYou,
      this.moneyYouOwe,
      this.paidMoney,
      this.receiviedTransferBalance,
      this.sendBalance});

  AccountStatementData.fromJson(Map<String, dynamic> json) {
    currentBalance = json['current_balance'];
    moneyOwedYou = json['money_owed_you'];
    moneyYouOwe = json['money_you_owe'];
    paidMoney = json['paid_money'];
    receiviedTransferBalance = json['receivied_transfer_balance'];
    sendBalance = json['send_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_balance'] = this.currentBalance;
    data['money_owed_you'] = this.moneyOwedYou;
    data['money_you_owe'] = this.moneyYouOwe;
    data['paid_money'] = this.paidMoney;
    data['receivied_transfer_balance'] = this.receiviedTransferBalance;
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

  SalePointDataUpdateRequestEntity({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.businessName,
    this.machineNumber,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "business_name": businessName,
        "machine_number": machineNumber,
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
