import 'package:flutter/material.dart';
import 'package:mask_free/controller/vaccinator_controllers/vaccinated_profile_controller.dart';
import 'package:mask_free/view/common_widgets/my_primary_button.dart';
import 'package:intl/intl.dart';

class VaccinatdProfilePage extends StatelessWidget {
  final VaccinatedProfileController controller = VaccinatedProfileController();

   VaccinatdProfilePage({Key key}) : super(key: key);
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ملف المريض'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            child: Card(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('الاسم',
                            style:
                                TextStyle(fontSize: 22, color: Colors.black)),
                        Text(controller.userModel.name,
                            style: TextStyle(
                                fontSize: 22, color: Colors.grey[850])),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[600],
                    indent: 22,
                    endIndent: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'تاريخ الميلاد',
                          style: TextStyle(fontSize: 22, color: Colors.black),
                        ),
                        Text(DateFormat.yMd().format(controller.userModel.dateOfBirth) ,
                            style: TextStyle(
                                fontSize: 22, color: Colors.grey[850])),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[600],
                    indent: 22,
                    endIndent: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        Text(
                          'الامراض المزمنة',
                          style: TextStyle(fontSize: 22, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount:0,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 4.0,horizontal: 22),
                            child: Row(
                              
                              children: [
                              Text(
                                controller.userModel.diseases[index],
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,fontSize: 22,),
                              ),
                            ]),
                            );
                      }),
                  Divider(
                    color: Colors.grey[600],
                    indent: 22,
                    endIndent: 22,
                  ),
                  Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(children: [Text('ملاحظات من المريض',
                     style: TextStyle(fontSize: 22, color: Colors.black),
                    )]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.75,
                    
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Container(
                      height: 100,
                      child: SingleChildScrollView(
                                              child: Text(
                         controller.userModel.notes ?? 'لا يوجد',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 24,  ),
                          maxLines: 4,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:22.0),
                    child: MyPrimaryButton(
                      text: 'عرض وثيقة الموافقة',
                      onPressed: () => controller.openConsentFormButton(context),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
