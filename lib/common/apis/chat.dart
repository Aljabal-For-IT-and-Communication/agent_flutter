
import 'package:app/common/utils/httpfile.dart';
import 'package:dio/dio.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class ChatAPI {

  static Future<BaseResponseEntity> bindFcmToken(
      {BindFcmTokenRequestEntity? params}
      ) async {
    var response = await HttpUtil().post(
      'agent/bind_fcmtoken',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  static Future<SendMessageResponseEntity> sendMessage(
      {ChatRequestEntity? params}
      ) async {
    var response = await HttpUtil().post(
      'agent/send_message',
      data: params?.toJson(),
    );
    return SendMessageResponseEntity.fromJson(response);
  }

  static Future<MessageResponseEntity> privateMessage(
      {TokenRequestEntity? params}
      ) async {
    var response = await HttpUtil().post(
      'agent/chat_list',
      data: params?.toJson(),
    );
    return MessageResponseEntity.fromJson(response);
  }


  static Future<BaseResponseEntity> upload_img(
      {XFile? file}
      ) async {

    String fileName = file!.path.split('/').last;

    FormData data = FormData.fromMap({
      'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
      ),
    });
    var response = await HttpFileUtil().post(
      'api/upload_file',
      data: data,
    );
    return BaseResponseEntity.fromJson(response);
  }





}
