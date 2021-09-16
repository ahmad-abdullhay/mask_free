import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_free/controller/vaccianted_controllers/appointment_order_controller.dart';
import 'package:mask_free/model/center_model.dart';

class CenterCard extends StatefulWidget {
  const CenterCard({
    Key key,
    this.center,
    this.controller,
    this.onTap,
  }) : super(key: key);
  final AppointmentOrderController controller;
  final CenterModel center;
  final Function onTap;

  @override
  _CenterCardState createState() => _CenterCardState();
}

class _CenterCardState extends State<CenterCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32),
        child: GestureDetector(
          onTap: () {
            if (widget.controller != null) {
              if (widget.center.isAvailable){
  widget.controller.selectedCenter = widget.center;
              widget.onTap();
              }else {
                    Fluttertoast.showToast(
                            msg: 'عذراً هذا المركز غير متاح حالياً يرجى اختيار مركز اخر',
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            fontSize: 16.0);
              }
            
            }
          },
          child: Card(
            color: widget.center.isAvailable ? Colors.white : Colors.grey,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('المركز'),
                      Text(widget.center.name),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('العنوان'),
                      Column(
                        children: [
                          Text(widget.center.location[1]),
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('رقم الهاتف'),
                      Text(widget.center.phoneNumber),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
