import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:mask_free/network/base_api.dart';
import 'package:mask_free/network/common_api.dart';
import 'package:mask_free/utlity/common_data.dart';
import 'package:mask_free/view/common_widgets/my_multi_selectable_drop_down_list.dart';
import 'package:mask_free/view/common_widgets/my_toast.dart';
import 'package:provider/provider.dart';

class InfoRegisterationController {
  String name;
  String gender;
  DateTime dateOfBirth;
  String notes;
  bool isEssentialWorker;
//
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MyMultiSelectableDropDownListController controller =
      MyMultiSelectableDropDownListController(
    allList: CommonData.allDiseases,
    hint: 'اختر الامراض المزمنة',
  );
  List<String> allGenders = CommonData.allGenders;

  Future<void> createAccount(BuildContext buildContext) async {
    if (formKey.currentState.validate()) {
      var userModel = Provider.of<UserModel>(buildContext, listen: false);
      _setValuesToUserModel(userModel);
      var response = await CommonApi().registerApi(userModel);
    await login (userModel);
      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(
            buildContext, '/VaccinatedMainPage', (route) => false);
      }else{
         MyToast.showToast('عذرا حدث خطأ! يرجى التأكد من المعلومات', buildContext);
      }
    }
  }
  Future<void> login (UserModel userModel) async {
     var response = await CommonApi().loginApi(userModel.nationalId, userModel.password);
    
      final responseJson = json.decode(response.toString());
      if (responseJson['message'] == null) {
      
        BaseApi.id = responseJson['user-id'].toString();
        BaseApi.token = responseJson['token'];
        userModel.jsonDecode(responseJson);
       
      }
  }

  void _setValuesToUserModel(UserModel userModel) {
    
    userModel.name = name;
    userModel.dateOfBirth = dateOfBirth;
    userModel.gender = gender;
    userModel.isEssentialWorker = isEssentialWorker;
    userModel.notes = notes;
    userModel.diseases = controller.selectedList;
  
  }
}
