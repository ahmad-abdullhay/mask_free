import 'package:flutter/material.dart';
import 'package:mask_free/controller/common_controllers/register_controller.dart';
import 'package:mask_free/utlity/validators.dart';
import 'package:mask_free/view/common_widgets/my_pages_steps_indicator.dart';
import 'package:mask_free/view/common_widgets/my_primary_button.dart';
import 'package:mask_free/view/common_widgets/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
      RegisterController registerController = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('انشاء حساب'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: registerController.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  MyPagesStepsIndicator(
                    text: 'انشاء حساب جديد',
                    secondText: 'بالبداية قم بادخال الرقم الوطني وكلمة المرور' ,
                    numberOfPages: 3,
                    currentPage: 0,
                  ),
                  
                  MyTextField(
                    onChange: (text) {
                      registerController.nationalId = text;
                    },
                    validator: Validators.idValidator,
                    hintText: 'ادخل الرقم الوطني',
                    isObscure: false,
                    iconData: Icons.one_k,
                    textInputType: TextInputType.number,
                  ),
                  MyTextField(
                    onChange: (text) {
                      registerController.password = text;
                    },
                    validator: Validators.passValidator,
                    hintText: 'ادخل كلمة المرور',
                    isObscure: true,
                    iconData: Icons.lock,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  MyTextField(
                    validator: (text) {
                      if (text != registerController.password)
                        return 'كلمة السر غير متطابقة';
                      else
                        return null;
                    },
                    hintText: 'ادخل كلمة المرور مرة اخرى',
                    isObscure: true,
                    iconData: Icons.lock,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  MyPrimaryButton(
                    onPressed: () =>
                        registerController.registerButtonClick(context),
                    text: 'انشاء حساب',
                  ),
                  SizedBox(height: 18,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

