import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:mask_free/network/base_api.dart';
import 'package:mask_free/view/common_pages/info_registeration_page.dart';
import 'package:mask_free/view/common_pages/phone_check_page.dart';
import 'package:mask_free/view/common_pages/register_page.dart';
import 'package:mask_free/view/common_pages/user_profile_page.dart';
import 'package:mask_free/view/common_pages/welcome_page.dart';
import 'package:mask_free/view/receptionist_pages/receptionist_main_page.dart';
import 'package:mask_free/view/receptionist_pages/user_info_page.dart';
import 'package:mask_free/view/vaccinated_pages/all_appointments_page.dart';
import 'package:mask_free/view/vaccinated_pages/appointment_order_page.dart';
import 'package:mask_free/view/vaccinated_pages/qrcode_page.dart';
import 'package:mask_free/view/vaccinated_pages/vaccinated_main_page.dart';
import 'package:mask_free/view/vaccinator_pages/consent_form_page.dart';
import 'package:mask_free/view/vaccinator_pages/vaccinated_profile_page.dart';
import 'package:mask_free/view/vaccinator_pages/vaccinator_main_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'view/common_pages/login_page.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  Widget getHomePage() {
    
    return WelcomePage();

  }
  Future<void> noti  () async {
 await Firebase.initializeApp();
 await Permission.camera.request();
  }
  Future<void> isEmulator () async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    bool isPhysicalDevice =  androidInfo.isPhysicalDevice;
    if (!isPhysicalDevice){
      BaseApi.basicRoute =  'http://10.0.2.2:8000';
    }else {
      BaseApi.basicRoute =  'http://192.168.43.50:8000';
    }
  }
  @override
  Widget build(BuildContext context) {
    isEmulator ();
  noti();
    return  ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        title: 'MaskFree',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'Cairo'
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("ar", "SA"),
        ],
        locale: Locale("ar", "SA"),
        initialRoute: '/',
        routes: {
          '/': (context) => getHomePage(),
          '/RegisterPage': (context) => RegisterPage(),
          '/LoginPage': (context) => LoginPage(),
          '/RegisterPage/PhoneCheckPage': (context) => PhoneCheckPage(),
          '/RegisterPage/PhoneCheckPage/InfoRegisterationPage': (context) =>
              InfoRegisterationPage(),
              //
              //
              //
          '/VaccinatorMainPage': (context) => VaccinatorMainPage(),
          '/VaccinatorMainPage/VaccinatedProfilePage': (context) =>
              VaccinatdProfilePage(),
          '/VaccinatorMainPage/VaccinatedProfilePage/ConsentFormPage':
              (context) => ConsentFormPage(),
          '/VaccinatorMainPage/UserProfilePage': (context) => UserProilePage(),
          '/VaccinatorMainPage/AllAppointmentsPage': (context) => AllAppointmentsPage(),
              //
              //
              //
          '/VaccinatedMainPage': (context) =>  VaccinatedMainPage(),
          
          '/VaccinatedMainPage/UserProfilePage': (context) => UserProilePage(),
          '/VaccinatedMainPage/AllAppointmentsPage': (context) => AllAppointmentsPage(),
          '/VaccinatedMainPage/AppointmentOrderPage': (context) =>
              AppointmentOrderPage(),
          '/VaccinatedMainPage/QRcodePage': (context) => QRcodePage(),
               //
               //
               '/ReceptionistMainPage': (context) => ReceptionistMainPage(),
               '/ReceptionistMainPage/UserInfoPage' : (context) => UserInfoPage(),
               '/ReceptionistMainPage/UserProfilePage': (context) => UserProilePage(),

        },
        //   home: ,
      ),
    );
  }
}
