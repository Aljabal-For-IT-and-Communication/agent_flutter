class OrderResponseEntity {
  int? code;
  List<OrderData>? data;
  String? msg;

  OrderResponseEntity({this.code, this.data, this.msg});

  OrderResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != "") {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}


class OrderData {
  int? id;
  int? userId;
  String? amountTotal;
  String? orderNum;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  OrderData(
      {this.id,
        this.userId,
        this.amountTotal,
        this.orderNum,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amountTotal = json['amount_total'];
    orderNum = json['order_num'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount_total'] = this.amountTotal;
    data['order_num'] = this.orderNum;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class OrderDetailResponseEntity {
  int? code;
  String? msg;
  List<OrderDetailData>? data;

  OrderDetailResponseEntity({this.code, this.msg, this.data});

  OrderDetailResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <OrderDetailData>[];
      json['data'].forEach((v) {
        data!.add(new OrderDetailData.fromJson(v));
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

class OrderDetailData {
  String? amount;
  int? cardId;
  String? createdAt;
  String? deletedAt;
  int? id;
  String? image;
  String? orderNum;
  String? price;
  int? quantity;
  int? salesPointId;
  String? serialNumber;
  int? supplierId;
  String? updatedAt;

  OrderDetailData(
      {this.amount,
        this.cardId,
        this.createdAt,
        this.deletedAt,
        this.id,
        this.image,
        this.orderNum,
        this.price,
        this.quantity,
        this.salesPointId,
        this.serialNumber,
        this.supplierId,
        this.updatedAt});

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    cardId = json['card_id'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    id = json['id'];
    image = json['image'];
    orderNum = json['order_num'];
    price = json['price'];
    quantity = json['quantity'];
    salesPointId = json['sales_point_id'];
    serialNumber = json['serial_number'];
    supplierId = json['supplier_id'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['card_id'] = this.cardId;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    data['id'] = this.id;
    data['image'] = this.image;
    data['order_num'] = this.orderNum;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['sales_point_id'] = this.salesPointId;
    data['serial_number'] = this.serialNumber;
    data['supplier_id'] = this.supplierId;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}