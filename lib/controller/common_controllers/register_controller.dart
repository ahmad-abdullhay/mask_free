import 'package:flutter/cupertino.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:provider/provider.dart';

class RegisterController {
  String nationalId;
  String password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> registerButtonClick(BuildContext context) async {
  
    if (formKey.currentState.validate()) {
      UserModel userModel = Provider.of<UserModel>(context, listen: false);
      userModel.nationalId = nationalId;
      userModel.password = password;
     
      if (true) {
        
        userModel.nationalId = nationalId;
      
        Navigator.pushNamed(context, '/RegisterPage/PhoneCheckPage');
      }
    }
  }


}
