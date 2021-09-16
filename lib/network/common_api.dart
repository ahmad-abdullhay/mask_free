import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:mask_free/network/base_api.dart';
import 'package:intl/intl.dart';
import 'package:mask_free/view/common_widgets/my_toast.dart';

class CommonApi extends BaseApi {
  void logout (bool isForced,BuildContext context){
    if (isForced)
    MyToast.showToast('حدث خطأ غير متوقع..يرجى تسجيل الدخول مرة أخرى', context);
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }
 Future<Response> loginApi(String id,String password) async {
    try {
      final response = await Dio().post(
        BaseApi.basicRoute+'/api/auth',
        queryParameters: {'identity_number': id, 'password': password,
        "noti_token": await FirebaseMessaging.instance.getToken()},
        options: getOptionsWithoutToken()
        
      );
      return response;
    } on DioError catch (en) {

      return en.response;
    }
  }
   Future<Response> registerApi(UserModel userModel) async {
    try {
      var date = DateFormat('yyyy-MM-dd').format(userModel.dateOfBirth);
      final response = await Dio().post(
      BaseApi. basicRoute + '/api/user/takers',
        queryParameters: {
          'identity_number': userModel.nationalId,
          'password': userModel.password,
          'first_name': userModel.name,
          'last_name': userModel.name,
          'father_name': userModel.name,
          'gender': userModel.gender == 'ذكر'? 'male' : 'female',
          'phone': userModel.phoneNumber,
          'birth_date': date,
          'has_medical_job': userModel.isEssentialWorker,
          'taker_type': 't',
          'noti_token': await FirebaseMessaging.instance.getToken(),
        },
        options: getOptionsWithoutToken()
      );
      return response;
    } on DioError catch (en) {
      return null;
    }
  }
  
  Future<Response> userProfileApi (String token) async {
     try {
      final response = await Dio().get(
       BaseApi. basicRoute+'/api/taker/takers/myProfile',
        options: getOptionsWithToken(token)
      );
      return response;
    } on DioError catch (en) {
      return en.response;
    }
  }
}