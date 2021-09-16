import 'package:flutter/material.dart';
import 'package:mask_free/controller/vaccianted_controllers/all_appointment_controller.dart';
import 'package:mask_free/model/appointment_model.dart';
import 'package:intl/intl.dart';
import 'package:mask_free/view/common_pages/user_profile_page.dart';
import 'package:mask_free/view/common_widgets/center_card.dart';
import 'package:mask_free/view/common_widgets/my_primary_button.dart';

class AllAppointmentsPage extends StatelessWidget {
  final AllAppointmentController controller = AllAppointmentController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('المواعيد'),
        ),
        body: SafeArea(
          child: ListView.builder(
              itemCount: controller.appointments.length,
              itemBuilder: (BuildContext context, int index) {
                return MyAppointmentCard(
                  appointmentModel: controller.appointments[index],
                );
              }),
        ));
  }
}

class MyAppointmentCard extends StatelessWidget {
  final AppointmentModel appointmentModel;

  const MyAppointmentCard({Key key, this.appointmentModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: <Widget>[
          Expanded(
              child: Divider(
            color: Colors.grey[850],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              DateFormat.yMd().format(appointmentModel.dateTime),
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
              child: Divider(
            color: Colors.grey[850],
          )),
        ]),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Column(children: getCardWidgets(context)+[]),
          ),
        ),
      ],
    );
  }

  List<Widget> getCardWidgets(var context) {
    if (appointmentModel.dateTime.isAfter(DateTime.now())) {
      return getNotYet(context);
    } else {
      if (appointmentModel.isEtended) {
        return getAttended(context);
      } else {
        return getNotAttended(context);
      }
    }
  }

  List<Widget> getAttended(var context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'لقد اخذت الجرعة',
            style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
          ),
          Icon (Icons.check,size: 30,color: Theme.of(context).primaryColor),
        ],
      ),
      MyInformationRow(
        title: 'نوع اللقاح',
        data: appointmentModel.vaccineTypeModel.type,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المركز',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                appointmentModel.centerModel.name,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          children: [
            CenterCard(
              center: appointmentModel.centerModel,
            )
          ],
        ),
      ),
    ];
  }

  List<Widget> getNotAttended(var context) {
    return [
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
           'لقد تغيبت عن الجرعة',
            style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
          ),
          Icon (Icons.phone_missed,size: 30,color: Theme.of(context).primaryColor),
        ],
      ),
    
      MyInformationRow(
        title: 'نوع اللقاح',
        data: appointmentModel.vaccineTypeModel.type,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المركز',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                appointmentModel.centerModel.name,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          children: [
            CenterCard(
              center: appointmentModel.centerModel,
            )
          ],
        ),
      ),
    ];
  }

  List<Widget> getNotYet(var context) {
    return [
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
           'لقد تم تحديد موعد الجرعة',
            style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
          ),
          Icon (Icons.calendar_today,size: 30,color: Theme.of(context).primaryColor),
        ],
      ),
     
      MyInformationRow(
        title: 'نوع اللقاح',
        data: appointmentModel.vaccineTypeModel.type,
      ),
      MyInformationRow(
        title: 'التاريخ',
        data: DateFormat.yMd().format(appointmentModel.dateTime),
      ),
      MyInformationRow(
        title: 'توقيت الحضور',
        data: DateFormat.Hms().format(appointmentModel.dateTime),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المركز',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                appointmentModel.centerModel.name,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          children: [
            CenterCard(
              center: appointmentModel.centerModel,
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyPrimaryButton(text:'الغاء الموعد',onPressed: (){
          
        },),
      )
    ];
  }
}
