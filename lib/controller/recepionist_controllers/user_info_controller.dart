import 'package:flutter/cupertino.dart';
import 'package:mask_free/controller/recepionist_controllers/receptionist_main_controller.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:mask_free/network/base_api.dart';
import 'package:mask_free/network/receptionist_api.dart';

class UserInfoController {
  UserModel userModel;


  void getData (){
    userModel = ReceptionistMainController.searchedUser;

  }
  confirmationButton (BuildContext context) async {
    await ReceptionistApi().verifiyDataApi(userModel.id, BaseApi.token); 
    Navigator.pop(context);
    
  }


}