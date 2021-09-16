import 'package:flutter/material.dart';
import 'package:mask_free/controller/vaccianted_controllers/qrcode_controller.dart';
import 'package:mask_free/view/common_widgets/my_qrcode_container.dart';

class QRcodePage extends StatefulWidget {
  @override
  _QRcodePageState createState() => _QRcodePageState();
}

class _QRcodePageState extends State<QRcodePage> {
  final QRcodeController controller = QRcodeController();
     void state() {
    setState(() {});
  }
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    controller.state = state;
   controller.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('qr code'),
       
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: QRcodeController.queueModel == null
              ? _qrCodeWidget(context)
              :  _queueWidget(context),
        ),
      ),
    );
  }

  Widget _qrCodeWidget(BuildContext context) {
    return Column(
      children: [
        Text(
          'عند الذهاب للمركز اعرض هذه الصفحة لموظف الاستقبال حتى يتم ادخالك للمركز',
          style: TextStyle(fontSize: 20),
        ),
        MyQRcodeContainer(
          text: controller.getUserId(context),
        ),
      ],
    );
  }

  Widget _queueWidget(BuildContext context) {
   
   
    return   Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text (QRcodeController.queueModel.room,style: TextStyle(fontSize: 26,color: Colors.black),),
          Text (QRcodeController.queueModel.estimatedWaitingTime),
          MyQRcodeContainer(text: controller.getUserId(context),),
          Text ('اعرض هذا الكود للممرض قبل اخذ اللقاح')
        ],
      ),
    );
  }
  



}
