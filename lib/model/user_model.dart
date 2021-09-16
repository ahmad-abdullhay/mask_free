import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  String nationalId;
  String password;
  String id;
  String phoneNumber;
  String name;
  DateTime dateOfBirth;
  String gender;
  List<String> diseases;
  String notes;
  bool isEssentialWorker;
  String token;
  String accountType;
  String vaccineState;
  UserModel({this.name, this.dateOfBirth, this.diseases, this.notes});

  void jsonDecode(Map<String, dynamic> json) {
    nationalId = json['identity_number'] ?? nationalId;
    password = json['password'] ?? password;
    id = json['id'].toString() ?? id;
    phoneNumber = json['phone'] ?? phoneNumber;
    name = json['first_name'] ?? name;
    gender = json['gender'] ?? gender;
    diseases = diseasesFromString(json['disease']) ?? diseases;
    notes = json['notes'] ?? notes;
    isEssentialWorker = json['isEssential'] ?? isEssentialWorker;
    token = json['token'] ?? token;
    accountType = json['user_role'] ?? accountType;
    vaccineState = json['state'] ?? 'vaccineState';
    try {
      dateOfBirth = DateTime.parse(json['birth_date']) ?? dateOfBirth;
    } catch (en) {}
  }

  List<String> diseasesFromString(String diseasesString) {
    if (diseasesString == null)
      return null;
    else
      return [];
  }
}
