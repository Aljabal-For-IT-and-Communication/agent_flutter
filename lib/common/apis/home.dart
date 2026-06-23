import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';

class HomeAPI {
  static Future<NotificationResponseEntity> notificationList(
      {PageOnlyRequestEntity? params}) async {
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

  static Future<PendingTransactionsResponseEntity>
      pendingTransactionsList() async {
    var response = await HttpUtil().post(
      'agent/pending_transactions_list',
    );
    return PendingTransactionsResponseEntity.fromJson(response);
  }
}
