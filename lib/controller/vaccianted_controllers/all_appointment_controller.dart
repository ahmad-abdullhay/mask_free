import 'package:mask_free/model/appointment_model.dart';
import 'package:mask_free/utlity/common_data.dart';

class AllAppointmentController {
  List<AppointmentModel> appointments = [
    AppointmentModel(
        centerModel: CommonData.allCenters[0],
        dateTime: DateTime.now().add(Duration(days: 2)),
        isEtended: false),
    AppointmentModel(
        centerModel: CommonData.allCenters[2],
        dateTime: DateTime.now(),
        isEtended: true),
    AppointmentModel(
        centerModel: CommonData.allCenters[1],
        dateTime: DateTime.now(),
        isEtended: false),
  ];
}
