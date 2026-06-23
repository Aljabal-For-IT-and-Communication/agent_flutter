class LoginRequestEntity {
  String? password;
  String? phone;

  LoginRequestEntity({
    this.password,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        "password": password,
        "phone": phone,
      };
}

class VerificationRequestEntity {
  String? phone;

  VerificationRequestEntity({
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        "phone": phone,
      };
}

class RegisterRequestEntity {
  String? firstName;
  String? middleName;
  String? lastName;
  String? businessName;
  int? city;
  int? region;
  String? address;
  String? phone;
  String? email;
  String? latitude;
  String? longitude;
  String? machineNumber;
  String? password;

  RegisterRequestEntity({
    this.firstName,
    this.middleName,
    this.lastName,
    this.businessName,
    this.city,
    this.region,
    this.address,
    this.phone,
    this.email,
    this.latitude,
    this.longitude,
    this.machineNumber,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "business_name": businessName,
        "city": city,
        "region": region,
        "address": address,
        "phone": phone,
        "email": email,
        "latitude": latitude,
        "longitude": longitude,
        "machine_number": machineNumber,
        "password": password,
      };
}

class ProfileRequestEntity {
  String? phone;

  ProfileRequestEntity({
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        "phone": phone,
      };
}

class ChangePasswordRequestEntity {
  String? password;
  String? repassword;

  ChangePasswordRequestEntity({
    this.password,
    this.repassword,
  });

  Map<String, dynamic> toJson() => {
        "password": password,
        "repassword": repassword,
      };
}

class ForgetPasswordRequestEntity {
  String? password;
  String? phone;
  String? verification_code;

  ForgetPasswordRequestEntity({
    this.password,
    this.phone,
    this.verification_code,
  });

  Map<String, dynamic> toJson() => {
        "password": password,
        "phone": phone,
        "verification_code": verification_code,
      };
}

class UserLoginResponseEntity {
  int? code;
  UserItem? data;
  String? msg;

  UserLoginResponseEntity({this.code, this.data, this.msg});

  UserLoginResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new UserItem.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class UserItem {
  String? accessToken;
  String? avatar;
  String? balance;
  int? city;
  String? email;
  String? firstName;
  int? id;
  String? indebtedness;
  String? lastName;
  String? maxIndebtedness;
  String? phone;
  int? region;
  String? realDebt;
  String? pendingRevenue;
  String? agentDebt;
  String? subAgentsDebt;
  String? salePointsDebt;
  String? token;

  UserItem(
      {this.accessToken,
      this.avatar,
      this.balance,
      this.city,
      this.email,
      this.firstName,
      this.id,
      this.indebtedness,
      this.lastName,
      this.maxIndebtedness,
      this.phone,
      this.region,
      this.realDebt,
      this.pendingRevenue,
      this.agentDebt,
      this.subAgentsDebt,
      this.salePointsDebt,
      this.token});

  UserItem.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    avatar = json['avatar'];
    balance = json['balance']?.toString();
    city = json['city'];
    email = json['email'];
    firstName = json['first_name'];
    id = json['id'];
    indebtedness = json['indebtedness']?.toString();
    lastName = json['last_name'];
    maxIndebtedness = json['max_indebtedness']?.toString();
    phone = json['phone'];
    region = json['region'];
    realDebt = json['real_debt']?.toString();
    pendingRevenue = json['pending_revenue']?.toString();
    agentDebt = json['agent_debt']?.toString();
    subAgentsDebt = json['sub_agents_debt']?.toString();
    salePointsDebt = json['sale_points_debt']?.toString();
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['avatar'] = this.avatar;
    data['balance'] = this.balance;
    data['city'] = this.city;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['indebtedness'] = this.indebtedness;
    data['last_name'] = this.lastName;
    data['max_indebtedness'] = this.maxIndebtedness;
    data['phone'] = this.phone;
    data['region'] = this.region;
    data['real_debt'] = this.realDebt;
    data['pending_revenue'] = this.pendingRevenue;
    data['sub_agents_debt'] = this.subAgentsDebt;
    data['sale_points_debt'] = this.salePointsDebt;
    data['agent_debt'] = this.agentDebt;
    data['token'] = this.token;
    return data;
  }
}
