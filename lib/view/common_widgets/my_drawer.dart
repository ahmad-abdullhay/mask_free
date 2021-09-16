import 'package:flutter/material.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:mask_free/network/common_api.dart';
import 'package:mask_free/view/common_widgets/drawer_item.dart';
import 'package:mask_free/view/vaccinated_pages/vaccinated_main_page.dart';

class MyDrawer extends StatelessWidget {
  final String accountType;
  final UserModel userModel;

  MyDrawer({Key key, this.accountType,@required this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userModel.name,style: TextStyle(color: Colors.black),),
            accountEmail: Text(userModel.phoneNumber,style: TextStyle(color: Colors.black),),
            decoration: BoxDecoration(
              image: DecorationImage(image:  new AssetImage('assets/images/register.png'),)
          
             ),
            ),
          getDrawerItems(context),
        ],
      ),
    );
  }

  Widget getDrawerItems(BuildContext context) {
    switch (accountType) {

      case 'vaccinator':
        {
          return Column(
            children: vaccinatorDrawerItems(context)+common(context),
          );
        }
      case 'vaccinated':
        {
          return Column(
            children:   vaccinatedDrawerItems(context)+common(context) 
          );
        }
      case 'receptionist':
        {
          return Column(
            children:   receptionistDrawerItems(context)+common(context) ,
          );
        }
     default:
      return Container();
    }

  }

  List<Widget> common(BuildContext context) {
    return [
       DrawerItem(
          text: 'حسابي',
          icon: Icons.account_circle_outlined,
          onTap: () {
            Navigator.pushNamed(context, '/${getPath()}/UserProfilePage');
          }),
      DrawerItem(
          text: 'المواعيد',
          icon: Icons.calendar_today,
          onTap: () {
            Navigator.pushNamed(context, '/${getPath()}/AllAppointmentsPage');
          }),
       DrawerItem(
          text: 'تسجيل الخروج',
          icon: Icons.logout,
          onTap: () {
            CommonApi().logout(false,context);
            
        
          }),
    ];
  }

  List<Widget> vaccinatedDrawerItems(BuildContext context) {
    return [

    ];
  }

  List<Widget> receptionistDrawerItems(BuildContext context) {
    return [
        DrawerItem(
          text: 'طلب موعد',
          icon: Icons.add,
          onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => VaccinatedMainPage(
                       isVaccinated: false,
                      )));
          }),
    ];
  }

  List<Widget> vaccinatorDrawerItems(BuildContext context) {
    return [
       DrawerItem(
          text: 'طلب موعد',
          icon: Icons.add,
          onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => VaccinatedMainPage(
                       isVaccinated: false,
                      )));
          }),
    ];
  }

  String getPath() {
    switch (accountType) {
      case 'vaccinator':
        {
          return 'VaccinatorMainPage';
        }
      case 'vaccinated':
        {
          return 'VaccinatedMainPage';
        }
      case 'receptionist':
        {
          return 'ReceptionistMainPage';
        }
    }
    return null;
  }
}
