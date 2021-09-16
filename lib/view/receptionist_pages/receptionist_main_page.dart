import 'package:flutter/material.dart';
import 'package:mask_free/controller/recepionist_controllers/receptionist_main_controller.dart';
import 'package:mask_free/view/common_widgets/my_drawer.dart';
import 'package:mask_free/view/common_widgets/my_primary_button.dart';

class ReceptionistMainPage extends StatefulWidget {
  @override
  _ReceptionistMainPageState createState() => _ReceptionistMainPageState();
}

class _ReceptionistMainPageState extends State<ReceptionistMainPage> {
  bool isLoading = true;
  final ReceptionistMainController controller = ReceptionistMainController();
  @override
  void initState() {
    setUserModel ();
    super.initState();
  }
  setUserModel () async {
   await controller.setUserModel(context);
   setState(() {
     isLoading = false;
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(userModel: controller.userModel,accountType:'receptionist'),
      appBar: AppBar (title: Text ('الصفحة الرئيسية'),),
      body: SafeArea (
        child: Center(
          child: isLoading ? CircularProgressIndicator() : Column (
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text ('لقد قمت بتسجيل الدخول كموظف استقبال'),
              Text ('قم بمسح الكود الخاص بالقادمين للمركز حتى يتم ادخالهم'),
              Divider(indent: 18,endIndent: 18,color: Colors.blueGrey,),
                MyPrimaryButton (
                  text: 'مسح',
                onPressed: ()=> controller.qrCodeScanButton(context),
                ),
            ],),
        ),
      ),
    );
  }
} 