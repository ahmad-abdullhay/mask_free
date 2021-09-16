import 'package:mask_free/model/center_model.dart';

class OrderModel {
  List<String>preferredDay;
  String id;
  DateTime date;
  CenterModel center;
  OrderModel ({this.id,this.center,this.date,this.preferredDay});
 static OrderModel fromJson (Map<String, dynamic> json,CenterModel  center){
    return OrderModel(
      id: json['id'].toString(),
      date:DateTime.parse( json['request_date']),
      center: center,
    );

  }

}