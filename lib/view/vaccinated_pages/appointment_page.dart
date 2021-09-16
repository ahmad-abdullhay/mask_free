import 'package:flutter/material.dart';
import 'package:mask_free/controller/vaccianted_controllers/appointment_controller.dart';
import 'package:intl/intl.dart';
import 'package:mask_free/controller/vaccianted_controllers/vaccinated_main_controller.dart';
import 'package:mask_free/view/common_widgets/center_card.dart';
import 'package:mask_free/view/common_widgets/my_primary_button.dart';
import 'package:mask_free/view/common_widgets/my_secondary_button.dart';

class AppointmentPage extends StatelessWidget {
    final VaccinatedMainController mainController;
    final AppointmentController controller = AppointmentController();

   AppointmentPage({Key key, this.mainController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
              child: ExpansionTile(

          leading:Image.asset('assets/images/dose.png'),
         
          title: Center(child: Text(mainController.userModel.vaccineState=='null'?
           'موعد الجرعة الاولى'
           :'موعد الجرعة الثانية')),
          children: [
           
  Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'تم تحديد موعد لاخذ لقاح كورونا',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('التاريخ',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    Text(
                        DateFormat.yMd().format(mainController.appointmentModel.dateTime),
                        style: TextStyle(fontSize: 18, color: Colors.grey[850])),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[600],
                indent: 36,
                endIndent: 36,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('الوقت',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    Text(
                        DateFormat.Hms().format(mainController.appointmentModel.dateTime),
                        style: TextStyle(fontSize: 18, color: Colors.grey[850])),
                  ],
                ),
              ),
              CenterCard(
                center: mainController.appointmentModel.centerModel,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyPrimaryButton(text: 'عرض Qr Code',onPressed: ()=> controller.showQRButton(context),),
                    MySecondaryButton(text: 'الغاء الموعد',onPressed: ()=> controller.cancelAppointmentButton(context,mainController),),
                  ],
                ),
              )
            ],
          ),
          ],
             
        ),
      ),
    );
  }
}
