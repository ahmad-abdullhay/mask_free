import 'package:flutter/material.dart';
import 'package:mask_free/controller/common_controllers/info_registeration_controller.dart';
import 'package:mask_free/utlity/validators.dart';
import 'package:mask_free/view/common_widgets/my_multi_selectable_drop_down_list.dart';
import 'package:mask_free/view/common_widgets/my_pages_steps_indicator.dart';
import 'package:mask_free/view/common_widgets/my_primary_button.dart';
import 'package:mask_free/view/common_widgets/my_text_field.dart';
import 'package:intl/intl.dart';

class InfoRegisterationPage extends StatefulWidget {
  @override
  _InfoRegisterationPageState createState() => _InfoRegisterationPageState();
}

class _InfoRegisterationPageState extends State<InfoRegisterationPage> {
  InfoRegisterationController infoRegisterationController =
      InfoRegisterationController();
  TextEditingController c = TextEditingController();
  bool dataAccept = false;
  bool isGenderValid = true;
  bool isFirstTry = false;
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: 'حدد تاريخ ميلادك',
      initialDatePickerMode: DatePickerMode.year,
      context: context,
      initialDate: DateTime(DateTime.now().year, 01, 01),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != infoRegisterationController.dateOfBirth)
      setState(() {
        infoRegisterationController.dateOfBirth = picked;

        c.text = DateFormat.yMd().format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    final double widthScale = 0.8;
    return Scaffold(
        appBar: AppBar(
          title: Text('انشاء ملف شخصي'),
        ),
        body: SafeArea(
          child: Form(
            key: infoRegisterationController.formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*widthScale,
                  child: Column(
                    children: [
                       MyPagesStepsIndicator(
                    text: 'انشاء حساب جديد',
                    secondText: 'اخيراً قم بملئ معلوماتك الشخصية' ,
                    numberOfPages: 3,
                    currentPage: 2,
                  ),
                      MyTextField(
                        hintText: 'ادخل اسمك الثلاثي',
                        textInputType: TextInputType.name,
                        validator: Validators.nameValidator,
                        onChange: (text) {
                          infoRegisterationController.name = text;
                        },
                        iconData: Icons.near_me,
                      ),
                      TextFormField(
                        
                        readOnly: true,
                        validator: Validators.dateValidator,
                        controller: c,
                        keyboardType: TextInputType.datetime,
                        style: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle,
                        decoration: InputDecoration(
                            labelText: 'حدد تاريخ ميلادك',
                            icon: Icon(Icons.calendar_today_outlined)),
                        onTap: () => _selectDate(context),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.face,
                            color: Colors.grey,
                          ),
                          SizedBox(width:MediaQuery.of(context).size.width*0.04),
                          Container(
                            width: MediaQuery.of(context).size.width*(widthScale-0.11),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text(
                                'اختر الجنس',
                                style: TextStyle(
                                    color: isGenderValid
                                        ? Theme.of(context).hintColor
                                        : Colors.red),
                              ),
                              value: infoRegisterationController.gender,
                              items: infoRegisterationController.allGenders
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                                                  child: Text(
                                      value,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColor),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                isGenderValid = true;
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                setState(() {
                                  infoRegisterationController.gender = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Padding(
                            padding: const EdgeInsets.only(top:12.0),
                            child: Icon(
                              Icons.local_hospital_outlined,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          SizedBox(width:MediaQuery.of(context).size.width*0.04),
                          Container(
                            width:MediaQuery.of(context).size.width*(widthScale-0.11),
                            child: MyMultiSelectableDropDownList(
                              controller:
                                  infoRegisterationController.controller,
                            ),
                          ),
                        ],
                      ),
                      Text('ملاحظات اضافية للطبيب'),
                      TextField(
                        onChanged: (value) {
                          infoRegisterationController.notes = value;
                        },
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        maxLines: 4,
                      ),
                      CheckboxListTile(
                        activeColor: Theme.of(context).primaryColor,
                        title: Text(
                          'هل تعمل بوظيفة طبية؟',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor),
                        ),
                        value:
                            infoRegisterationController.isEssentialWorker ??
                                false,
                        onChanged: (value) {
                          setState(() {
                            infoRegisterationController.isEssentialWorker =
                                value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        subtitle: !dataAccept && isFirstTry
                            ? Text(
                                'يجب الموافقة',
                                style: TextStyle(color: Colors.red),
                              )
                            : null,
                        activeColor: Theme.of(context).primaryColor,
                        title: Text(
                          'اوافق على شروط سياسة الاستخدام',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor),
                        ),
                        value: dataAccept,
                        onChanged: (value) {
                          setState(() {
                            dataAccept = value;
                          });
                        },
                      ),
                    
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: MyPrimaryButton(
                            text: 'تسجيل',
                            onPressed: () {
                              if (infoRegisterationController
                                      .formKey.currentState
                                      .validate() &&
                                  dataAccept &&
                                  infoRegisterationController.gender != null) {
                                infoRegisterationController
                                    .createAccount(context);
                              } else {
                                setState(() {
                                  isGenderValid = false;
                                });
                              }
                              if (!isFirstTry) isFirstTry = true;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
