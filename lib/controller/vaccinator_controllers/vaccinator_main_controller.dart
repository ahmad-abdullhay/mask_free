import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:mask_free/network/base_api.dart';
import 'package:mask_free/network/common_api.dart';
import 'package:mask_free/network/vaccinator_api.dart';
import 'package:mask_free/view/common_widgets/my_toast.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class VaccinatorMainController {
  
  UserModel userModel;
static UserModel searchedUser;
Future<void> setUserModel (BuildContext context) async {
   userModel = Provider.of<UserModel>(context, listen: false);
 var response =await  CommonApi().userProfileApi(BaseApi.token);
   if (json.decode(response.toString())['message'] == null){
     userModel.jsonDecode(json.decode(response.toString()));
   } else {
     CommonApi().logout(true, context);
   }
}


    Future _scan() async {
    String id = await scanner.scan();
  return id;
  }
  qrCodeScanButton(BuildContext context) async {
   String result =  await _scan();
   var user = await doSearch(result);
   if (user == null){
     MyToast.showToast('عذرا لم يتم ايجاد المستخدم', context);
     return;
   } else {
     searchedUser = user;
    Navigator.pushNamed(context,'/VaccinatorMainPage/VaccinatedProfilePage');
   }
  }
  Future<UserModel> doSearch (String id) async{
    var response =await VaccinatorApi().searchByIdApi(id, BaseApi.token);

     final responseJson = json.decode(response.toString());
     if (responseJson['id']!= null){
       var userModel =  UserModel();
       userModel.jsonDecode(responseJson);
      return userModel; 
     } else {
       return null;
     }
  }
}