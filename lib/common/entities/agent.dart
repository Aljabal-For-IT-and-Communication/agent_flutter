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
  String? balance;
  String? firstName;
  int? id;
  String? indebtedness;
  String? realDebt;
  String? pendingRevenue;
  String? agentDebt;
  String? subAgentsDebt;
  String? salePointsDebt;
  String? lastName;
  String? middleName;
  String? phone;

  AgentData(
      {this.balance,
      this.firstName,
      this.id,
      this.indebtedness,
      this.realDebt,
      this.pendingRevenue,
      this.agentDebt,
      this.subAgentsDebt,
      this.salePointsDebt,
      this.lastName,
      this.middleName,
      this.phone});

  AgentData.fromJson(Map<String, dynamic> json) {
    balance = json['balance']?.toString();
    firstName = json['first_name'];
    id = json['id'];
    indebtedness = json['indebtedness']?.toString();
    realDebt = json['real_debt']?.toString();
    pendingRevenue = json['pending_revenue']?.toString();
    agentDebt = json['agent_debt']?.toString();
    subAgentsDebt = json['sub_agents_debt']?.toString();
    salePointsDebt = json['sale_points_debt']?.toString();
    lastName = json['last_name'];
    middleName = json['middle_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['indebtedness'] = this.indebtedness;
    data['real_debt'] = this.realDebt;
    data['pending_revenue'] = this.pendingRevenue;
    data['agent_debt'] = this.agentDebt;
    data['sub_agents_debt'] = this.subAgentsDebt;
    data['sale_points_debt'] = this.salePointsDebt;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['phone'] = this.phone;
    return data;
  }
}
