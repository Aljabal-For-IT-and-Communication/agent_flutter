class AgentResponseEntity {
  int? code;
  String? msg;
  List<AgentData>? data;

  AgentResponseEntity({this.code, this.msg, this.data});

  AgentResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <AgentData>[];
      json['data'].forEach((v) {
        data!.add(new AgentData.fromJson(v));
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

class AgentData {
  String? avatar;
  String? balance;
  int? cid;
  String? firstName;
  int? id;
  String? indebtedness;
  String? lastName;
  String? middleName;
  String? phone;
  String? token;

  AgentData(
      {this.avatar,
      this.balance,
      this.cid,
      this.firstName,
      this.id,
      this.indebtedness,
      this.lastName,
      this.middleName,
      this.phone,
      this.token});

  AgentData.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    balance = json['balance'];
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
