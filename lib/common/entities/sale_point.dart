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
  String? firstName;
  int? id;
  String? indebtedness;
  String? lastName;
  String? middleName;
  String? phone;
  String? token;

  SalePointData(
      {this.avatar,
        this.balance,
        this.businessName,
        this.cid,
        this.firstName,
        this.id,
        this.indebtedness,
        this.lastName,
        this.middleName,
        this.phone,
        this.token});

  SalePointData.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    balance = json['balance'];
    businessName = json['business_name'];
    cid = json['cid'];
    firstName = json['first_name'];
    id = json['id'];
    indebtedness = json['indebtedness'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    phone = json['phone'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['balance'] = this.balance;
    data['business_name'] = this.businessName;
    data['cid'] = this.cid;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['indebtedness'] = this.indebtedness;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['phone'] = this.phone;
    data['token'] = this.token;
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
    data = json['data'] != null ? new AccountStatementData.fromJson(json['data']) : null;
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