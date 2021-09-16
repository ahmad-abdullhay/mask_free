import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mask_free/model/center_model.dart';
import 'package:mask_free/model/order_model.dart';
import 'package:mask_free/network/base_api.dart';
import 'package:mask_free/network/common_api.dart';
import 'package:mask_free/network/vaccinated_api.dart';
import 'package:mask_free/utlity/common_data.dart';
import 'package:mask_free/view/common_widgets/center_card.dart';
import 'package:mask_free/view/common_widgets/my_alert_dialog.dart';
import 'package:mask_free/view/common_widgets/my_multi_selectable_drop_down_list.dart';

class AppointmentOrderController {
  bool isCouldOrder;
  OrderModel order;
  List<String> cities = [];
  CenterModel selectedCenter;

  List<CenterModel> allCenters;
  MyMultiSelectableDropDownListController listController =
      MyMultiSelectableDropDownListController(
          allList: CommonData.allDays, hint: 'اختر الايام المناسبة');
  Future setCenters () async{
    var  response = await VaccinatedApi().getCentersApi(BaseApi.token);
    if (response.statusCode == 200){
      final jsonResponse = json.decode(response.toString());
      allCenters = (jsonResponse as List).map((e) => CenterModel.fromJson(e)).toList();
      setCities  ();
    }
  }
  void setCities (){
    cities  =  [];
        for (CenterModel center in allCenters) {
      if (!cities.contains(center.location[0])) cities.add(center.location[0]);
    }
  }

  Future<void> isHasOrder (BuildContext context) async {
       var response = await VaccinatedApi().isHasOrderApi(BaseApi.id, BaseApi.token);
      
    if (response.statusCode == 200) {
      
      final responseJson = json.decode(response.toString());
      if (responseJson['hasrequest'] != null) {
        if (responseJson['hasrequest'] == 'user has no request') {
           await setIsCouldOrder();
        }
      }
      else{
      
          if (responseJson['request']['center_id' ]!= null){
             var center=  CenterModel.fromJson(responseJson['center']);
  
           order = OrderModel.fromJson(responseJson['request'], center);
          }
        
        } 
    } else  {
     CommonApi().logout(true, context);
    }
  }
  Future<void> setIsCouldOrder () async {
      var response = await VaccinatedApi().isCouldOrderApi(BaseApi.id, BaseApi.token);
    
      isCouldOrder = true;
  }
  Future<void> setOrder(BuildContext context) async {
    var response = await VaccinatedApi().setOrderApi( BaseApi.token,selectedCenter);
      final jsonResponse = json.decode(response.toString());

  
    order = OrderModel.fromJson(jsonResponse,null);
  }
  
  
  Future<void> cancelOrder() async {
    
    VaccinatedApi().cancelOrderApi(order.id, BaseApi.token);
    order = null;
    selectedCenter = null;
   await setIsCouldOrder();
  }

  setOrderButton(BuildContext context, Function confirm) {
    MyAlertDialog(
      title: 'تأكيد الموعد',
      confirmFunction: () async {
       await setOrder(context);
        Navigator.pop(context);
        confirm();
      },
      text:
          "هل حقاً ترغب في تأكيد الموعد\nقد يترتب عليك غرامات في حالة التغيب عن الموعد",
    ).show(context);
  }

  void cancelOrderButton(BuildContext context, Function confirm) {
    MyAlertDialog(
      title: "الغاء الطلب",
      confirmFunction: () async {
       await cancelOrder();
        Navigator.pop(context);
        confirm();
      },
      text:
          "هل حقاً ترغب في الغاء الطلب\nقد لا تتمكن من طلب موعد اخر في حالة الالغاء المتكرر",
    ).show(context);
  }

  List<Widget> buildExpandableContent(String city, Function onTap) {
    List<Widget> columnContent = [];
    for (CenterModel centerModel in allCenters) {
      if (centerModel.location[0] == city)
        columnContent.add(
            CenterCard(center: centerModel, controller: this, onTap: onTap));
    }

    return columnContent;
  }
}
