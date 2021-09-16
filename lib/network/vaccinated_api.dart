import 'package:dio/dio.dart';
import 'package:mask_free/model/center_model.dart';
import 'package:mask_free/network/base_api.dart';
import 'package:intl/intl.dart';


class VaccinatedApi extends BaseApi {
  Future<Response> hasAppointment(String id, String token) async {
    try {
      final response = await Dio().get(
        BaseApi.basicRoute + '/api/takers/$id/hasAppointment',
        options: getOptionsWithToken(token),
      );
    
      return response;
    } on DioError catch (en) {
      return en.response;
    }
  }

  Future<Response> isHasOrderApi(String id, String token) async {
    try {
      final response = await Dio().get(
        BaseApi.basicRoute + '/api/takers/$id/hasRequest',
        options: getOptionsWithToken(token),
      );
      return response;
    } on DioError catch (en) {
      return en.response;
    }
  }

  Future<Response> setOrderApi(String token,CenterModel centerModel) async {
    try {
    
      final response = await Dio().post(
         BaseApi. basicRoute + '/api/request/requests',
          queryParameters: {"center_id":centerModel.id,
          "request_date" : DateFormat('yyyy-MM-dd').format(DateTime.now()),
          },
          options: getOptionsWithToken(token));
      return response;
     
    } on DioError catch (en) {
       
      return en.response;
    }
  }

  Future<Response> cancelOrderApi(String id, String token) async {

    try {
     
      final response = await Dio().delete(
          BaseApi.basicRoute + '/api/requests/$id',
          options: getOptionsWithToken(token));
      return response;
    } on DioError catch (en) {
    
      return en.response;
    }
  }

  Future<Response> isCouldOrderApi(String id, String token) async {
 try {
      final response = await Dio().get(
          BaseApi.basicRoute + '/api/takers/$id/hasRequest',
          options: getOptionsWithToken(token));
      return response;
  
    } on DioError catch (en) {
      return en.response;
    }
  }
    Future<Response>getCentersApi(String token) async {
 try {
      final response = await Dio().get(
         BaseApi. basicRoute + '/api/center/centers',
          options: getOptionsWithTokenForArray(token));
         
      return response;
      
    } on DioError catch (en) {
      return en.response;
    }
  }
}
