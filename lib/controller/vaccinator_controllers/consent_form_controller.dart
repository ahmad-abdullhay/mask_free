
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_free/controller/vaccinator_controllers/vaccinator_main_controller.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:mask_free/network/base_api.dart';
import 'package:mask_free/network/vaccinator_api.dart';
import 'package:signature/signature.dart';

class ConsentFormController {
  UserModel userModel;
  ConsentFormController (){
  userModel = VaccinatorMainController.searchedUser;
}
  String consentFormText;
  String vaccinatedSignture;
  final SignatureController signtureController = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Future<bool> confirmButton(BuildContext context) async {
    if (signtureController.isEmpty) {
      return false;
    } else {
      VaccinatorApi().addVaccineApi(userModel.id, BaseApi.token);
      showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(scale: a1.value, child: fun(context));
          },
          transitionDuration: Duration(milliseconds: 300),
          barrierDismissible: false,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) => fun(context));
      Future.delayed(Duration(seconds: 5), () {
        Navigator.popUntil(context, ModalRoute.withName('/VaccinatorMainPage'));
      });
    
      return true;
    }
  }

  Widget fun(BuildContext context) {
    return AlertDialog(
      shape: CircleBorder(
          ),
      content:  Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(
            Icons.check,
            size: MediaQuery.of(context).size.width * 0.45,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            'تم تسجيل اللقاح بنجاح',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 30,)
        ]),
      ),
    );
  }
}
