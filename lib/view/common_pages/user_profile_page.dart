import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_free/controller/common_controllers/user_profile_controller.dart';
import 'package:mask_free/view/common_widgets/my_qrcode_container.dart';

class UserProilePage extends StatefulWidget {
  @override
  _UserProilePageState createState() => _UserProilePageState();
}

class _UserProilePageState extends State<UserProilePage> {
  final UserProfileController controller = UserProfileController();
  bool isLodaing = true;
  @override
  void initState() {
    loadUserProfile ();
    super.initState();
  }
  loadUserProfile () async {
    await controller.getUserModel(context);
    setState(() {
      isLodaing = false;
    });
  }
  String getState (){
      
    switch (controller.userModel.vaccineState) {
      case 'protected':
        return 'محصن';
      case 'half protected':
        return 'محصن جرعة  واحدة';
      case 'null':
        return 'غير محصن';
    }
    return 'محصن جرعة واحدة';
  
  }
  @override
  Widget build(BuildContext context) {
    controller.getUserModel(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('حسابي'),
      ),
      body: SafeArea(
        child: isLodaing ?
        Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
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
                    title: 'رقم الجوال',
                    data: controller.userModel.phoneNumber,
                  ),
                  MyInformationRow(
                    title: 'تاريخ الميلاد',
                    data:
                        DateFormat.yMd().format(controller.userModel.dateOfBirth),
                  ),
                  MyInformationRow(
                      title: 'الحالة', data:getState ()),
                        MyQRcodeContainer(text: controller.userModel.id,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyInformationRow extends StatelessWidget {
  const MyInformationRow({
    Key key,
    this.title,
    this.data,
  }) : super(key: key);

  final String title;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize:18, color: Colors.black),
              ),
              Text(data,
                  style: TextStyle(fontSize: 18, color: Colors.grey[850])),
            ],
          ),
        ),
        Divider(
          color: Colors.grey[600],
          indent: 22,
          endIndent: 22,
        ),
      ],
    );
  }
}
