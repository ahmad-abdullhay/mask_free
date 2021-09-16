import 'package:mask_free/model/center_model.dart';
import 'package:mask_free/model/vaccine_type_model.dart';

class AppointmentModel {
  String id;
  DateTime dateTime;
  CenterModel centerModel;
  bool isEtended;
  VaccineTypeModel vaccineTypeModel = VaccineTypeModel();
AppointmentModel ({this.id,this.centerModel,this.dateTime,this.isEtended});

 static AppointmentModel fromJson (Map<String, dynamic> json,CenterModel  center){
    return AppointmentModel(
      id: json['id'].toString(),
      dateTime:DateTime.parse( json['appointment_date']),
      centerModel: center,
      isEtended: false
    );

  }
}