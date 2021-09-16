import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_free/controller/vaccianted_controllers/appointment_order_controller.dart';
import 'package:mask_free/view/common_widgets/center_card.dart';
import 'package:mask_free/view/common_widgets/my_primary_button.dart';
import 'package:intl/intl.dart';

class AppointmentOrderPage extends StatefulWidget {
  @override
  _AppointmentOrderPageState createState() => _AppointmentOrderPageState();
}

class _AppointmentOrderPageState extends State<AppointmentOrderPage> {
   bool isLoading = true;
  AppointmentOrderController controller = AppointmentOrderController();
  void state() {
    setState(() {});
  }

  initState(){
    hasOrderCheck();
    super.initState();
  }
  Future<void> hasOrderCheck () async {
     await controller.setCenters();
    await controller.isHasOrder(context);
   
    setState(() {
      isLoading = false;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(child: CircularProgressIndicator()) : controller.order == null
        ? AppointmentOrder(controller: controller, state: state)
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                      'تم طلب موعد في تاريخ ${DateFormat.yMd().format(controller.order.date)}',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  Text('ستتم معالجة الطلب في غضون يومان',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  Divider(
                    color: Colors.grey[850],
                    endIndent: 20,
                    indent: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyPrimaryButton(
                      text: 'الغاء الطلب',
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        controller.cancelOrderButton(context, () {
                          setState(() { isLoading = false;});
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class AppointmentOrder extends StatefulWidget {
  const AppointmentOrder({
    Key key,
    @required this.controller,
    this.state,
  }) : super(key: key);

  final AppointmentOrderController controller;
  final Function state;
  @override
  _AppointmentOrderState createState() => _AppointmentOrderState();
}

class _AppointmentOrderState extends State<AppointmentOrder> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children : widget.controller.isCouldOrder ? [
             Text(
                'انت مؤهل لطلب موعد لاخذ اللقاح\nاولاً قم بتحديد المركز الانسب لك ثم اضغط على طلب موعد',
                style: TextStyle(
                  fontSize: 20,
                )),
            Divider(
              color: Colors.grey[850],
            ),
            widget.controller.selectedCenter == null
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    itemCount: widget.controller.cities.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExpansionTile(
                          title: Text(widget.controller.cities[index]),
                          children: widget.controller.buildExpandableContent(
                              widget.controller.cities[index], () {
                            setState(() {});
                          }));
                    })
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'تم تحديد',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            widget.controller.selectedCenter.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              tooltip: 'الغاء التحديد',
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                setState(() {
                                  widget.controller.selectedCenter = null;
                                });
                              }),
                        ],
                      ),
                      CenterCard(
                        center: widget.controller.selectedCenter,
                      ),
                    ],
                  ),
      
            MyPrimaryButton(
                text: 'طلب موعد',
                isEnabled:
                    widget.controller.selectedCenter == null ? false : true,
                onPressed: () {
                  if (widget.controller.selectedCenter == null) {
                    Fluttertoast.showToast(
                        msg: "عذرا يجب تحديد مركز اولاً",
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    widget.controller.setOrderButton(context, () {
                      widget.state();
                    });
                  }
                }),


          ] : [
            Center(child: Text('انت من الفئات العمرية الغير مؤهلة حاليا لاخذ اللقاح')),
            Center(child: Text('سيتم فتح التسجيل على اللقاح قريباً')),
          ],
        
        ),
      ),
    );
  }
}
