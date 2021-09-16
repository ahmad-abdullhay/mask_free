import 'package:flutter/cupertino.dart';
import 'package:mask_free/controller/vaccianted_controllers/vaccinated_main_controller.dart';
import 'package:mask_free/model/appointment_model.dart';
import 'package:mask_free/utlity/common_data.dart';
import 'package:mask_free/view/common_widgets/my_alert_dialog.dart';
import 'package:mask_free/view/common_widgets/my_toast.dart';

class AppointmentController {
  AppointmentModel appointmentModel =
      AppointmentModel(
          centerModel: CommonData.allCenters[2], dateTime: DateTime.now());

  void showQRButton(BuildContext context) {
    Navigator.pushNamed(context, '/VaccinatedMainPage/QRcodePage');
  }

  void cancelAppointment(VaccinatedMainController mainController) {
    appointmentModel = null;
    mainController.isHasAppointment = false;
    mainController.state();
  }

  void cancelAppointmentButton(
      BuildContext context, VaccinatedMainController mainController) {
        MyToast.showToast('عذرا لا يمكنك الغاء الموعد في الوقت الحالي', context);
        return;
    MyAlertDialog(
      title: "تأكيد الغاء الموعد",
      confirmFunction: () {
        cancelAppointment(mainController);
        Navigator.pop(context);
      },
      text:
          "هل حقاً ترغب في الغاء الموعد\nقد لا تتمكن من طلب موعد اخر في حالة الالغاء المتكرر",
    ).show(context);
  }
}
