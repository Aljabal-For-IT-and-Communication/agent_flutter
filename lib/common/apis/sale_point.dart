import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:dio/dio.dart';

class SalePointAPI {
  static Future<SalePointResponseEntity> salePointList() async {
    var response = await HttpUtil().post(
      'agent/sale_point_list',
    );
    return SalePointResponseEntity.fromJson(response);
  }

  static Future<SalePointResponseEntity> salePointPickerList() async {
    var response = await HttpUtil().post(
      'agent/sale_point_picker_list',
    );
    return SalePointResponseEntity.fromJson(response);
  }

  static Future<AgentRechargeRecordResponseEntity> salePointRechargeRecordList(
      {TransferRecordListRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/sale_point_recharge_record_list',
      data: params?.toJson(),
    );
    return AgentRechargeRecordResponseEntity.fromJson(response);
  }

  static Future<AgentCollectRecordResponseEntity> salePointCollectRecordList(
      {TransferRecordListRequestEntity? params}) async {
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
      {DateRangeRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/transfer_collection_total_record',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<TransferCollectionResponseEntity> transferCollection(
      {TransferCollectionRequestEntity? params}) async {
    const endpoint = 'agent/transfer_collection';
    final requestId = await Idempotency.getOrCreate(
      endpoint: endpoint,
      fingerprintData: {
        'category': params?.category,
        'amount': params?.amount,
        'id': params?.id,
        'transfer_type': params?.transferType,
        'file_path': params?.validationFilePath,
        'file_name': params?.validationFileName,
      },
    );
    final data = params == null ? null : await params.toRequestBody();
    var response = await HttpUtil().post(
      endpoint,
      data: data,
      options: Options(
        headers: {Idempotency.headerName: requestId},
        receiveTimeout: Idempotency.testReceiveTimeout,
      ),
    );
    await Idempotency.clearIfFinal(endpoint, requestId, response);
    return TransferCollectionResponseEntity.fromJson(response);
  }

  static Future<SuperRechargeRecordResponseEntity> superRechargeRecordList(
      {PageOnlyRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/super_recharge_record_list',
      data: params?.toJson(),
    );
    return SuperRechargeRecordResponseEntity.fromJson(response);
  }

  static Future<ChildRechargeRecordResponseEntity> superCollectRecordList(
      {PageOnlyRequestEntity? params}) async {
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
      {DateRangeRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'agent/account_statement',
      data: params?.toJson(),
    );
    return AccountStatementResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> transferBalance(
      {TransferBalanceRequestEntity? params}) async {
    const endpoint = 'agent/transfer_balance';
    final requestId = await Idempotency.getOrCreate(
      endpoint: endpoint,
      fingerprintData: {
        'category': params?.category,
        'amount': params?.amount,
        'id': params?.id,
        'converter': params?.converter,
        'transfer_type': params?.transferType,
        'file_path': params?.validationFilePath,
        'file_name': params?.validationFileName,
      },
    );
    final data = params == null ? null : await params.toRequestBody();
    var response = await HttpUtil().post(
      endpoint,
      data: data,
      options: Options(
        headers: {Idempotency.headerName: requestId},
        receiveTimeout: Idempotency.testReceiveTimeout,
      ),
    );
    await Idempotency.clearIfFinal(endpoint, requestId, response);
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

  static Future<BaseResponseEntity> deleteSalePoint({
    SalePointIdRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'agent/delete_sale_point',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
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

  static Future<SalePointPasswordResponseEntity> resetPassword({
    SalePointIdRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'agent/sale_point_reset_password',
      data: params?.toJson(),
    );
    return SalePointPasswordResponseEntity.fromJson(response);
  }

  static Future<WalletPasswordResponseEntity> getWalletPassword({
    SalePointIdRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'agent/sale_point_wallet_password',
      data: params?.toJson(),
    );
    return WalletPasswordResponseEntity.fromJson(response);
  }
}
