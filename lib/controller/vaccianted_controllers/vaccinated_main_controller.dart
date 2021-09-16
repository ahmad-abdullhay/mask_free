import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mask_free/model/appointment_model.dart';
import 'package:mask_free/model/center_model.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:mask_free/network/base_api.dart';
import 'package:mask_free/network/common_api.dart';
import 'package:mask_free/network/vaccinated_api.dart';
import 'package:provider/provider.dart';

class VaccinatedMainController {
  bool isHasAppointment;
  AppointmentModel appointmentModel;
  Function state;
  UserModel userModel;
  Future<void> getUserProfile (BuildContext context) async {
    userModel = Provider.of<UserModel>(context, listen: false);
     var response= await CommonApi().userProfileApi(BaseApi.token);
      if (json.decode(response.toString())['message'] == null){
     userModel.jsonDecode(json.decode(response.toString()));
   } else {
     CommonApi().logout(true, context);
   }
  }
  Future<void> hasAppointment(BuildContext context) async {
    
  var response= await VaccinatedApi().hasAppointment(BaseApi.id,BaseApi.token);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.toString());
      if (responseJson['hasAppointment'] != null) {
        if (responseJson['hasAppointment'] == 'user has no appointment') {
          isHasAppointment = false;
        } 
      } else {
         if (responseJson['appointment']['center_id' ]!= null){
             var center=  CenterModel.fromJson(responseJson['center']);
             
            appointmentModel = AppointmentModel.fromJson(responseJson['appointment'],center);
              isHasAppointment = true;
          }
     
         
        
      }
    }
  }

    Future<List<CenterModel>> setCenters () async{
    var  response = await VaccinatedApi().getCentersApi(BaseApi.token);
    if (response.statusCode == 200){
      final jsonResponse = json.decode(response.toString());
    
     return (jsonResponse as List).map((e) => CenterModel.fromJson(e)).toList();
    }
    return null;
  }
}
