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
      'agent/register',
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

  static Future<BaseResponseEntity> forgetPassword({
    ForgetPasswordRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'agent/forget_password',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> sendCode({
    VerificationRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'agent/send_code',
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

  static Future<BaseResponseEntity> updateProfile({
    ProfileRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'agent/update_profile',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }


}
