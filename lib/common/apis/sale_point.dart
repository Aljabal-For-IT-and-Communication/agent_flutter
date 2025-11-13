import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';

class SalePointAPI {
  static Future<SalePointResponseEntity> salePointList() async {
    var response = await HttpUtil().post(
      'agent/sale_point_list',
    );
    return SalePointResponseEntity.fromJson(response);
  }

  static Future<AgentRechargeRecordResponseEntity> salePointRechargeRecordList(
      {TransferRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/sale_point_recharge_record_list',
      data: params?.toJson(),
    );
    return AgentRechargeRecordResponseEntity.fromJson(response);
  }

  static Future<AgentCollectRecordResponseEntity> salePointCollectRecordList(
      {TransferRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/sale_point_collect_record_list',
      data: params?.toJson(),
    );
    return AgentCollectRecordResponseEntity.fromJson(response);
  }

  static Future<AgentCollectRecordResponseEntity> transferCollectionList(
      {DateRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/transfer_collection_list',
      data: params?.toJson(),
    );
    return AgentCollectRecordResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> transferCollectionTotalRecord(
      {DateRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/transfer_collection_total_record',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<TransferCollectionResponseEntity> transferCollection(
      {TransferRequestEntity? params}) async {
    final data = params == null ? null : await params.toRequestBody();
    var response = await HttpUtil().post(
      'agent/transfer_collection',
      data: data,
    );
    return TransferCollectionResponseEntity.fromJson(response);
  }

  static Future<SuperRechargeRecordResponseEntity> superRechargeRecordList(
      {PageRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/super_recharge_record_list',
      data: params?.toJson(),
    );
    return SuperRechargeRecordResponseEntity.fromJson(response);
  }

  static Future<ChildRechargeRecordResponseEntity> superCollectRecordList(
      {PageRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/super_collect_record_list',
      data: params?.toJson(),
    );
    return ChildRechargeRecordResponseEntity.fromJson(response);
  }

  static Future<ChildRechargeRecordResponseEntity>
      childRechargeRecordList() async {
    var response = await HttpUtil().post(
      'agent/child_recharge_record_list',
    );
    return ChildRechargeRecordResponseEntity.fromJson(response);
  }

  static Future<AccountStatementResponseEntity> accountStatement(
      {DateRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/account_statement',
      data: params?.toJson(),
    );
    return AccountStatementResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> transferBalance(
      {TransferBalanceRequestEntity? params}) async {
    final data = params == null ? null : await params.toRequestBody();
    var response = await HttpUtil().post(
      'agent/transfer_balance',
      data: data,
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> requestCredit(
      {AmountRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/request_credit',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  // Recharge and Collect types
  static Future<RechargeTypesResponseEntity> rechargeTypesList() async {
    var response = await HttpUtil().post(
      'agent/recharge_types_list',
    );
    return RechargeTypesResponseEntity.fromJson(response);
  }

  static Future<CollectTypesResponseEntity> collectTypesList() async {
    var response = await HttpUtil().post(
      'agent/collect_types_list',
    );
    return CollectTypesResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> salePointDataUpdate({
    SalePointDataUpdateRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'agent/sale_point_data_update',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> salePointStatusUpdate({
    SalePointStatusUpdateRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'agent/sale_point_status_update',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }
}
