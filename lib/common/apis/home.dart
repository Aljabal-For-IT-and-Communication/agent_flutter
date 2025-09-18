import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';

class HomeAPI {
  static Future<NotificationResponseEntity> notificationList(
      {PageRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/notification',
      data: params?.toJson(),
    );
    return NotificationResponseEntity.fromJson(response);
  }

  static Future<ShippingOperationResponseEntity> shippingOperationList(
      {PageRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/shipping_operation',
      data: params?.toJson(),
    );
    return ShippingOperationResponseEntity.fromJson(response);
  }

  static Future<PendingCollectionsResponseEntity> pendingCollectionsList(
      {PageRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/pending_collections_list',
      data: params?.toJson(),
    );
    return PendingCollectionsResponseEntity.fromJson(response);
  }

  static Future<PendingRechargesResponseEntity> pendingRechargesList(
      {PageRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/pending_recharges_list',
      data: params?.toJson(),
    );
    return PendingRechargesResponseEntity.fromJson(response);
  }
}
