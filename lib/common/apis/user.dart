import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';

class UserAPI {
  static Future<UserLoginResponseEntity> Login({
    LoginRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'agent/login',
      data: params?.toJson(),
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> register({
    RegisterRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'agent/sale_point_create',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> changePassword({
    ChangePasswordRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'agent/change_password',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<UserLoginResponseEntity> getProfile() async {
    var response = await HttpUtil().post(
      'agent/get_profile',
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  static Future<UserLoginResponseEntity> getBalanceSummary() async {
    var response = await HttpUtil().post(
      'agent/get_balance_summary',
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> updateProfile({
    ProfileRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'agent/update_profile',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<AgentDeviceResponseEntity> deviceList() async {
    final response = await HttpUtil().post('agent/device_list', data: {});
    return AgentDeviceResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> authorizeDevice({
    required AgentDeviceActionRequestEntity params,
  }) async {
    final response = await HttpUtil().post(
      'agent/device_authorize',
      data: params.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> denyDevice({
    required AgentDeviceActionRequestEntity params,
  }) async {
    final response = await HttpUtil().post(
      'agent/device_deny',
      data: params.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> revokeDevice({
    required AgentDeviceActionRequestEntity params,
  }) async {
    final response = await HttpUtil().post(
      'agent/device_revoke',
      data: params.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }
}
