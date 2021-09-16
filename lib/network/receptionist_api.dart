import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mask_free/network/base_api.dart';

class ReceptionistApi extends BaseApi {
  Future<Response> searchByIdApi (String id,String token) async {
        try {
      final response = await Dio().get(
        BaseApi.basicRoute+'/api/receptionist/takers/$id',
        queryParameters: {"token": await FirebaseMessaging.instance.getToken()},
       
        options: getOptionsWithToken(BaseApi.token),
      );
      
      return response;
      
    } on DioError catch (en) {
      return en.response;
    }
  }
    Future<Response> verifiyDataApi (String id,String token) async {
        try {
      final response = await Dio().post(
        BaseApi.basicRoute+'/api/receptionist/$id',
       
        options: getOptionsWithToken(BaseApi.token),
      );
      return response;
     
    } on DioError catch (en) {
      return en.response;
    }
  }
}