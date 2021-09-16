import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_free/model/queue_model.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:provider/provider.dart';

class QRcodeController {
  Function state;
  BuildContext context;
  bool isDone = false;
  static QueueModel queueModel;
  Future<void> noti() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (queueModel == null) {
        queueModel =
            QueueModel(ququeId: "a", estimatedWaitingTime: '10 دقائق انتظار', room: 'الغرفة الاولى');
        state();
      } else {
        _doneDialog(context);
      }
    });
  }

  QRcodeController() {
    noti();
  }
  String getUserId(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context, listen: false);
    return userModel.id;
  }

  Widget fun(BuildContext context) {
    return AlertDialog(
      shape: CircleBorder(),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.check,
            size: MediaQuery.of(context).size.width * 0.45,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            'تم تسجيل اللقاح بنجاح',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: 30,
          )
        ]),
      ),
    );
  }

  _doneDialog(BuildContext context) {
    queueModel = null;
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(scale: a1.value, child: fun(context));
        },
        transitionDuration: Duration(milliseconds: 300),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) => fun(context));
    Future.delayed(Duration(seconds: 5), () {
      Navigator.popUntil(context, (route) => route.isFirst);
     
    });
  }
}
