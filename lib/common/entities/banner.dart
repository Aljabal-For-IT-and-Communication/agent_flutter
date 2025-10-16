class BannerResponseEntity {
  int? code;
  String? msg;
  List<BannerData>? data;

  BannerResponseEntity({this.code, this.msg, this.data});

  BannerResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data!.add(new BannerData.fromJson(v));
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

class BannerData {
  String? createdAt;
  String? deletedAt;
  int? id;
  String? image;
  String? name;
  int? status;
  String? updatedAt;

  BannerData(
      {this.createdAt,
      this.deletedAt,
      this.id,
      this.image,
      this.name,
      this.status,
      this.updatedAt});

  BannerData.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
    status = json['status'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
