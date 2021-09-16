import 'package:flutter/material.dart';
import 'package:mask_free/controller/vaccianted_controllers/vaccinated_main_controller.dart';
import 'package:mask_free/model/user_model.dart';
import 'package:mask_free/view/common_widgets/my_drawer.dart';
import 'package:mask_free/view/common_widgets/my_qrcode_container.dart';
import 'package:mask_free/view/vaccinated_pages/appointment_order_page.dart';
import 'package:mask_free/view/vaccinated_pages/appointment_page.dart';

class VaccinatedMainPage extends StatefulWidget {
  final bool isVaccinated;
  const VaccinatedMainPage({Key key, this.isVaccinated}) : super(key: key);
  @override
  _VaccinatedMainPageState createState() => _VaccinatedMainPageState();
}

class _VaccinatedMainPageState extends State<VaccinatedMainPage> {
  
  final VaccinatedMainController controller = VaccinatedMainController();
  bool isLoading = true;
  @override
  void initState() {
    setIsVaccinated();
    controller.state = state;
    isHasRequest();
    super.initState();
  }

  Future<void> isHasRequest() async {
    await controller.hasAppointment(context);
    await controller.getUserProfile(context);
    setState(() {
      isLoading = false;
    });
  }

  void state() {
    setState(() {});
  }

  bool isVaccinated;
  void setIsVaccinated() {
    isVaccinated = widget.isVaccinated;
    if (isVaccinated == null) isVaccinated = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerEnableOpenDragGesture: isVaccinated,
        appBar: isVaccinated
      ? AppBar(
          actions: [
           IconButton(icon: Icon(Icons.refresh,
        color: Colors.white,
        ), onPressed: (){
           Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => super.widget));
        })
          ],
          title: Text('الصفحة الرئيسية'),
        )
      : AppBar(
          title: Text('صفحة طلب اللقاح'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
           actions: [
           IconButton(icon: Icon(Icons.refresh,
        color: Colors.white,
        ), onPressed: (){
           Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => super.widget));
        })
          ],
        ),
        drawer: MyDrawer(
    userModel: controller.userModel,
    accountType: 'vaccinated',
        ),
        body: SafeArea(
    child: !isLoading
        ? SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  _ProfileCard( 
                    userModel: controller.userModel,
                  ), 
                  controller.isHasAppointment
                      ?controller.userModel.vaccineState == 'protected' ? Container(): AppointmentPage(mainController: controller)
                      : controller.userModel.vaccineState != 'protected'? Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ExpansionTile(
                              title: Text('طلب موعد'),
                              children: [AppointmentOrderPage()]),
                        ) : Container()
                ],
              ),
            ),
          )
        : Center(child: CircularProgressIndicator()),
        ),
      );
  }
}

class _ProfileCard extends StatelessWidget {
  final UserModel userModel;
  String getState() {
    switch (userModel.vaccineState) {
      case 'protected':
        return 'محصن';
      case 'half protected':
        return 'محصن جرعة واحدة';
      case 'null':
        return 'غير محصن';
    }
    return 'error';
  }

  Color getStateColor() {
    switch (userModel.vaccineState) {
      case 'protected':
        return Colors.greenAccent[400];
      case 'half protected':
        return Colors.orangeAccent[400];
      case 'null':
        return Colors.redAccent[400];
    }
    return Colors.orangeAccent[400];
  }

  const _ProfileCard({Key key, @required this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                     userModel.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  indent: 15,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.local_hospital,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'لا يوجد فحص كورونا',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Divider(
                  indent: 15,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.shield,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                  children: [
                                    MyQRcodeContainer(
                                      text: userModel.id,
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          color: getStateColor(),
                          child: Text(
                            getState(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
