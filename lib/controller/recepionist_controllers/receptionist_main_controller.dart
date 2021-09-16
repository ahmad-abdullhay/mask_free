

import 'dart:convert';
import 'package:mask_free/network/receptionist_api.dart';
import 'package:mask_free/view/common_widgets/my_toast.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:mask_free/network/base_api.dart';
import 'package:mask_free/network/common_api.dart';
import 'package:provider/provider.dart';

class ReceptionistMainController {
  UserModel userModel;
static UserModel searchedUser;
      Future _scan() async {
   return await scanner.scan();
   
  }
  qrCodeScanButton(BuildContext context) async {
   String result =  await _scan();
  
   var user = await doSearch(result);
   if (user == null){
     MyToast.showToast('عذرا لم يتم ايجاد المستخدم', context);
     return;
   } else {
     searchedUser = user;
    Navigator.pushNamed(context,'/ReceptionistMainPage/UserInfoPage');
   }
  }
  Future<UserModel> doSearch (String id) async{
    var response =await ReceptionistApi().searchByIdApi(id, BaseApi.token);
     final responseJson = json.decode(response.toString());
     if (responseJson['id']!= null){
       var userModel =  UserModel();
       userModel.jsonDecode(responseJson);
      return userModel; 
     } else {
       return null;
     }
  }
Future<void> setUserModel (BuildContext context) async {
   userModel = Provider.of<UserModel>(context, listen: false);
 var response =await  CommonApi().userProfileApi(BaseApi.token);
   if (json.decode(response.toString())['message'] == null){
     userModel.jsonDecode(json.decode(response.toString()));
   } else {
     CommonApi().logout(true, context);
   }

}
}