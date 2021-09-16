import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mask_free/controller/common_controllers/phone_check_controller.dart';
import 'package:mask_free/utlity/validators.dart';
import 'package:mask_free/view/common_widgets/my_pages_steps_indicator.dart';
import 'package:mask_free/view/common_widgets/my_primary_button.dart';
import 'package:mask_free/view/common_widgets/my_secondary_button.dart';
import 'package:mask_free/view/common_widgets/my_text_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneCheckPage extends StatefulWidget {
  @override
  _PhoneCheckPageState createState() => _PhoneCheckPageState();
}

class _PhoneCheckPageState extends State<PhoneCheckPage> {
  PhoneCheckController phoneCheckController = PhoneCheckController();
  StreamController<ErrorAnimationType> errorController;
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ادخال رقم الجوال'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                  MyPagesStepsIndicator(
                    text: 'انشاء حساب جديد',
                    secondText:phoneCheckController.isEntered ? 'يرجى ادخال رمز التحقق المرسل' :'ثانياً قم بادخال رقم الهاتف',
                    numberOfPages: 3,
                    currentPage: 1,
                  ),
                !phoneCheckController.isEntered
                    ? Form(
                        key: phoneCheckController.phoneNumbeFormKey,
                        child: Column(
                          children: [
                            MyTextField(
                              hintText: 'ادخل رقم الجوال',
                              validator: Validators.phoneNumberValidator,
                              textInputType: TextInputType.phone,
                              iconData: Icons.phone,
                              onChange: (text) {
                                phoneCheckController.phoneNumber =  text;
                              },
                            ),
                            MyPrimaryButton(
                              text: 'الاستمرار',
                              onPressed: () {
                                setState(() {
                                  phoneCheckController.isEntered =
                                      phoneCheckController.phoneNumbeFormKey.currentState.validate();
                                     
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    : Form(
                        key: phoneCheckController.codeFormKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.65,
                                child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        activeColor: Colors.teal,
                        selectedFillColor: Colors.white,
                        selectedColor: Colors.teal,
                        inactiveFillColor: Colors.white,
                        inactiveColor: Colors.grey

                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 250),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: phoneCheckController.textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          phoneCheckController.code = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        return false;
                      },
                    ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MyPrimaryButton(
                                  text: 'تأكيد',
                                  onPressed: () => phoneCheckController
                                      .codeCheckButton(context),
                                ),
                                MySecondaryButton(
                                  text: 'الغاء',
                                  onPressed: () {
                                    if (phoneCheckController
                                        .phoneCancelButton()) {
                                      setState(() {
                                        phoneCheckController.isEntered = false;
                                      });
                                    }
                                  },
                                )
                              ],
                            )
                          ],
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
