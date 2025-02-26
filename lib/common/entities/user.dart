

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
   String? first_name;
   String? middle_name;
   String? last_name;
   String? city;
   String? area;
   String? phone;
   String? email;
   String? password;

  RegisterRequestEntity({
    this.password,
    this.email,
    this.first_name,
    this.middle_name,
    this.last_name,
    this.city,
    this.area,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
    "password": password,
    "email": email,
    "first_name": first_name,
    "middle_name": middle_name,
    "last_name": last_name,
    "city": city,
    "area": area,
    "phone": phone,
  };
}
class ProfileRequestEntity {
  int? gender;
  String? birthday;
  String? description;
  String? phone;
  String? name;

  ProfileRequestEntity({
    this.gender,
    this.birthday,
    this.description,
    this.phone,
    this.name,
  });

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "birthday": birthday,
    "description": description,
    "phone": phone,
    "name": name,
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
  int? cid;
  int? city;
  String? createdAt;
  String? deletedAt;
  String? email;
  String? firstName;
  int? id;
  String? indebtedness;
  String? lastName;
  int? level;
  String? maxBalance;
  String? maxIndebtedness;
  String? middleName;
  String? phone;
  int? pid;
  String? profit;
  int? region;
  int? status;
  String? token;
  String? updatedAt;

  UserItem(
      {this.accessToken,
        this.avatar,
        this.balance,
        this.cid,
        this.city,
        this.createdAt,
        this.deletedAt,
        this.email,
        this.firstName,
        this.id,
        this.indebtedness,
        this.lastName,
        this.level,
        this.maxBalance,
        this.maxIndebtedness,
        this.middleName,
        this.phone,
        this.pid,
        this.profit,
        this.region,
        this.status,
        this.token,
        this.updatedAt});

  UserItem.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    avatar = json['avatar'];
    balance = json['balance'];
    cid = json['cid'];
    city = json['city'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    email = json['email'];
    firstName = json['first_name'];
    id = json['id'];
    indebtedness = json['indebtedness'];
    lastName = json['last_name'];
    level = json['level'];
    maxBalance = json['max_balance'];
    maxIndebtedness = json['max_indebtedness'];
    middleName = json['middle_name'];
    phone = json['phone'];
    pid = json['pid'];
    profit = json['profit'];
    region = json['region'];
    status = json['status'];
    token = json['token'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['avatar'] = this.avatar;
    data['balance'] = this.balance;
    data['cid'] = this.cid;
    data['city'] = this.city;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['indebtedness'] = this.indebtedness;
    data['last_name'] = this.lastName;
    data['level'] = this.level;
    data['max_balance'] = this.maxBalance;
    data['max_indebtedness'] = this.maxIndebtedness;
    data['middle_name'] = this.middleName;
    data['phone'] = this.phone;
    data['pid'] = this.pid;
    data['profit'] = this.profit;
    data['region'] = this.region;
    data['status'] = this.status;
    data['token'] = this.token;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}







