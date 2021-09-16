import 'package:flutter/material.dart';
import 'package:mask_free/controller/recepionist_controllers/user_info_controller.dart';
import 'package:mask_free/view/common_pages/user_profile_page.dart';
import 'package:mask_free/view/common_widgets/my_primary_button.dart';
import 'package:intl/intl.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final UserInfoController controller = UserInfoController();
  bool isLoading = true;
  @override
  void initState() {
    getUserData ();
    super.initState();
  }
void getUserData () async {

setState(() {
  controller.getData();
  isLoading =false;
});
}
  @override
  Widget build(BuildContext context) {
    controller.getData();
    return Scaffold(
      appBar: AppBar (title: Text('معلومات المتلقح'),),
      body: SafeArea (
        child: Column (
          children: [
            MyInformationRow(
              title: 'الاسم',
              data: controller.userModel.name,
            ),
            MyInformationRow(
                title: 'الرقم الوطني',
              data: controller.userModel.nationalId,
            ),
            MyInformationRow(
                title: 'تاريخ الميلاد',
              data:DateFormat.yMd().format(controller.userModel.dateOfBirth) ,
            ),
            MyInformationRow(
                title: 'الجنس',
              data: controller.userModel.gender == 'male' ? 'ذكر' : 'انثى' ,
            ),
              MyInformationRow(
                title: 'رقم الهاتف',
              data: controller.userModel.phoneNumber,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyPrimaryButton( 
                text: 'تم التأكد من المعلومات',
                onPressed: ()=> controller.confirmationButton(context),
              ),
            )
          ],
         ),
      ),
    );
  }
}