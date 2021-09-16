import 'package:flutter/cupertino.dart';
import 'package:mask_free/controller/vaccinator_controllers/vaccinator_main_controller.dart';
import 'package:mask_free/model/user_model.dart';

class VaccinatedProfileController {

  UserModel userModel;
VaccinatedProfileController (){
  userModel = VaccinatorMainController.searchedUser;
}
  void openConsentFormButton(BuildContext context) {
    Navigator.pushNamed(
        context, '/VaccinatorMainPage/VaccinatedProfilePage/ConsentFormPage');
  }
}
