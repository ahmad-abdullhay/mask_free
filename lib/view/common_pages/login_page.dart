import 'package:flutter/material.dart';
import 'package:mask_free/controller/common_controllers/login_controller.dart';
import 'package:mask_free/utlity/validators.dart';
import 'package:mask_free/view/common_widgets/my_primary_button.dart';
import 'package:mask_free/view/common_widgets/my_secondary_button.dart';
import 'package:mask_free/view/common_widgets/my_text_field.dart';
import 'package:mask_free/view/common_widgets/my_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoginning = false;
  LoginController loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.teal[300]])),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('تسجيل الدخول'),
        ),
        body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: isLoginning,
            child: SingleChildScrollView(
              child: Form(
                key: loginController.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/login.png',
                        width: 0.7 * MediaQuery.of(context).size.width,
                      ),
                      Text(
                        'مرحبا مجدداً',
                        style: TextStyle(color: Colors.black, fontSize: 42),
                      ),
                      Text(
                        'قم بتسجيل الدخول او قم بانشاء حساب جديد',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18),
                      ),
                      MyTextField(
                        onChange: (text) {
                          loginController.nationalId = text;
                        },
                        validator: Validators.idValidator,
                        hintText: 'ادخل الرقم الوطني',
                        isObscure: false,
                        iconData: Icons.one_k,
                        textInputType: TextInputType.number,
                      ),
                      MyTextField(
                        onChange: (text) {
                          loginController.password = text;
                        },
                        validator: Validators.passValidator,
                        hintText: 'ادخل كلمة المرور',
                        isObscure: true,
                        iconData: Icons.lock,
                        textInputType: TextInputType.visiblePassword,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MyPrimaryButton(
                            onPressed: () async {
                              setState(() {
                                isLoginning = true;
                              });
                              String errorMessage = await loginController
                                  .loginButtonClick(context);
                              setState(() {
                                isLoginning = false;
                                if (errorMessage != null) {
                                  MyToast.showToast(errorMessage, context);
                                }
                              });
                            },
                            text: 'تسجيل الدخول',
                          ),
                          MySecondaryButton(
                            onPressed: () =>
                                loginController.registerButtonClick(context),
                            text: 'انشاء حساب',
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
