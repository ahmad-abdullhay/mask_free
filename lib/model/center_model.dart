class CenterModel {
  String id;
  String name;
  List<String> location;
  String phoneNumber;
  bool isAvailable;
  CenterModel({this.id,this.name,this.location,this.phoneNumber,this.isAvailable});
  static CenterModel fromJson (Map<String, dynamic> json){
    return CenterModel(
      id: json['id'].toString(),
      name: json['name'],
      isAvailable: true,
      phoneNumber: json['phones'][0],
      location: [json['city'],json['street'],'تفاصيل'], 
    );

  }
}