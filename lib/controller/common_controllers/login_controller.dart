import 'package:flutter/material.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:mask_free/network/base_api.dart';
import 'package:mask_free/network/common_api.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';

class LoginController {
  String nationalId;
  String password;
  UserModel userModel;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<String> loginButtonClick(BuildContext context) async {
    userModel = Provider.of<UserModel>(context, listen: false);
    if (formKey.currentState.validate()) {
      var response = await CommonApi().loginApi(nationalId, password);
    
      final responseJson = json.decode(response.toString());
      if (responseJson == null) return 'يرجى التحقق من الرقم الوطني او كلمة المرور';
      if (responseJson['message'] == null) {
        userModel.nationalId = nationalId;
        BaseApi.id = responseJson['user-id'].toString();
        BaseApi.token = responseJson['token'];
        userModel.jsonDecode(responseJson);
        navigate(context);
      } else {
        return 'يرجى التحقق من الرقم الوطني او كلمة المرور';
      }
    }
     return null;
  }

  void navigate(BuildContext context) {
    switch (userModel.accountType) {
      case 'vaccinator':
        Navigator.pushNamedAndRemoveUntil(
            context, '/VaccinatorMainPage', (route) => false);
        break;
      case 'taker':
        Navigator.pushNamedAndRemoveUntil(
            context, '/VaccinatedMainPage', (route) => false);
        break;
      case 'receptionist':
        Navigator.pushNamedAndRemoveUntil(
            context, '/ReceptionistMainPage', (route) => false);
        break;
    }
  }

  

  void registerButtonClick(BuildContext context) {
    Navigator.pushNamed(context, '/RegisterPage');
  }
}
