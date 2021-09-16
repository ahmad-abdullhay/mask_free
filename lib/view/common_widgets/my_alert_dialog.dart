import 'package:flutter/material.dart';

class MyAlertDialog  {
  final String title;
  final String text;
  final Function confirmFunction;

  MyAlertDialog({this.title, this.text, this.confirmFunction} );
  void show (BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
              text),
          actions: [
            TextButton(
                onPressed: confirmFunction,
                child: Text('تأكيد')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('خروج'))
          ],
        );
      },
    );
  }

}