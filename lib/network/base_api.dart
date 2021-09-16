import 'package:dio/dio.dart';

class BaseApi {
  static String basicRoute = 'http://10.0.2.2:8000';
 static String id ;
 static String token;

  
  Options getOptionsWithToken (String token){
    return Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "authorization": "token $token",
            
          },
        );
  }
  Options getOptionsWithTokenForArray (String token){
    return Options(
      responseType: ResponseType.plain,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "authorization": "token $token",
            
          },
        );
  }
    Options getOptionsWithoutToken (){
    return Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        );
  }
}