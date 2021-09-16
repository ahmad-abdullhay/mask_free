import 'package:flutter/material.dart';
import 'package:mask_free/controller/vaccinator_controllers/consent_form_controller.dart';
import 'package:mask_free/view/common_widgets/my_primary_button.dart';
import 'package:signature/signature.dart';

class ConsentFormPage extends StatefulWidget {
  @override
  _ConsentFormPageState createState() => _ConsentFormPageState();
}

class _ConsentFormPageState extends State<ConsentFormPage> {
  ConsentFormController controller = ConsentFormController();
  bool isSigntureValidate = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('وثيقة الموافقة على اخذ اللقاح'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                RichText(
                    text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 18,fontFamily: 'Cairo'),
                  children: [
                    TextSpan(
                      text: 'اتعهد بأن ليس لدي كل ما هو مذكور ادناه:\n',
                      style: TextStyle(fontSize: 20,fontFamily: 'Cairo'),
                    ),
                    TextSpan(
                      text:
                          '\t\t\t\t1) دخول للعناية المركزة بسبب فايروس كورونا\n',
                    ),
                    TextSpan(
                        text: '\t\t\t\t2) حساسية شديدة من اللقاحات سابقاً\n'),
                    TextSpan(text: '\t\t\t\t3) مرض السرطان\n'),
                    TextSpan(text: '\t\t\t\t4) مشخص بنقص المناعة'),
                  ],
                )),
                Divider(
                  color: Colors.grey[850],
                ),
                Text(
                  'سيتم اعطاء هذا اللقاح المستوفي لكافة شروط تسجيل اللقاح حسب قوانين ولوائح الجمهورية العربية السورية من قبل اخصائي الرعاية',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Divider(
                  color: Colors.grey[850],
                ),
                Text(
                  'بالتوقيع ادناه,أوافق على أخذ لقاح كوفيد-19',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Signature(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.7,
                      controller: controller.signtureController,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                isSigntureValidate
                    ? Container()
                    : Text(
                        'يجب التوقيع قبل تثبيت اللقاح',
                        style: TextStyle(color: Colors.red, fontSize: 22),
                      ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MyPrimaryButton(
                    text: 'تثبيت اخذ اللقاح',
                    onPressed: () async {
                      if (!await controller.confirmButton(context)) {
                        setState(() {
                          isSigntureValidate = false;
                        });
                      } else {
                        setState(() {
                          isSigntureValidate = true;
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
