import 'package:flutter/cupertino.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:provider/provider.dart';

class PhoneCheckController {
  String phoneNumber;
  String code;
  GlobalKey<FormState> phoneNumbeFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> codeFormKey = GlobalKey<FormState>();
   TextEditingController textEditingController = TextEditingController();
  bool isEntered = false;
  Future<bool> phoneNumberEnteredButton() async {
    if (phoneNumbeFormKey.currentState.validate()) {

            return true;
    }
    return false;
  }
  
  
  bool phoneCancelButton (){
    return true;

  }
  void codeCheckButton(BuildContext context) {
    if (codeFormKey.currentState.validate()) {
    
      UserModel userModel = Provider.of<UserModel>(context, listen: false);
    
      //
      // api code
      //
      if (true) {
        //temp code
        userModel.phoneNumber = phoneNumber;
        //
        Navigator.pushNamed(
            context, '/RegisterPage/PhoneCheckPage/InfoRegisterationPage');
      }
    }
  }

     
}
