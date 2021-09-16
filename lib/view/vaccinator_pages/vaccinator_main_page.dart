import 'package:flutter/material.dart';
import 'package:mask_free/controller/vaccinator_controllers/vaccinator_main_controller.dart';
import 'package:mask_free/view/common_widgets/my_drawer.dart';
import 'package:mask_free/view/common_widgets/my_primary_button.dart';

class VaccinatorMainPage extends StatefulWidget {
  @override
  _VaccinatorMainPageState createState() => _VaccinatorMainPageState();
}

class _VaccinatorMainPageState extends State<VaccinatorMainPage> {
  VaccinatorMainController controller = VaccinatorMainController();
  bool isLoading = true;
  @override
  void initState() {
   setUserModel();
    super.initState();
  }
  Future<void> setUserModel () async {
  await  controller.setUserModel(context);
  setState(() {
    isLoading = false;
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(accountType:'vaccinator',userModel: controller.userModel,),
      appBar: AppBar(
        title: Text('مسح QR code'),
      ),
      body: SafeArea(
          child: Center(
            child:isLoading ? CircularProgressIndicator() : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text ('لقد قمت بتسجيل الدخول كممرض'),
              Text ('قم بمسح الكود الخاص بالمراجعين حتى يتم عرض شهادة اللقاح'),
              Divider(indent: 18,endIndent: 18,color: Colors.blueGrey,),
                MyPrimaryButton(
                  text: 'مسح',
                  onPressed: () => controller.qrCodeScanButton(context),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
