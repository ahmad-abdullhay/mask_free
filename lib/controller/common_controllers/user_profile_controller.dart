
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:mask_free/network/base_api.dart';
import 'package:mask_free/network/common_api.dart';
import 'package:provider/provider.dart';

class UserProfileController {
  UserModel userModel;
  String vaccineState;
  Future<void> getUserModel(BuildContext context) async {
    
    userModel = Provider.of<UserModel>(context, listen: false);
   var response =await CommonApi().userProfileApi(BaseApi.token);
   if (json.decode(response.toString())['message'] == null){
     userModel.jsonDecode(json.decode(response.toString()));
   } else {
    
     Navigator.pop(context);
   }
  }
}
