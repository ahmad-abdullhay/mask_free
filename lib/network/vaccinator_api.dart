
import 'package:dio/dio.dart';
import 'package:mask_free/network/base_api.dart';

class VaccinatorApi extends BaseApi {

    Future<Response> searchByIdApi (String id,String token) async {
        try {
      
      final response = await Dio().get(
        BaseApi.basicRoute+'/api/vaccinator/takers/$id',
        options: getOptionsWithToken(BaseApi.token),
      );
    
      return response;
    } on DioError catch (en) {
      
       

      return en.response;
    }
  }
  Future<Response> addVaccineApi (String id,String token)  async {
            try {
      final response = await Dio().post(
       BaseApi. basicRoute+'/api/vaccinator/appointments/$id',

        options: getOptionsWithToken(BaseApi.token),
      );
      return response;
    } on DioError catch (en) {
      return en.response;
    }
  }

}