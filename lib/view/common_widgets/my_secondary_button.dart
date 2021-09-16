import 'package:flutter/material.dart';

class MySecondaryButton extends StatelessWidget {
  const MySecondaryButton({
        this.onPressed, this.text,
  });

  final Function onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
        backgroundColor:MaterialStateProperty.all(Colors.white) ,
        overlayColor: MaterialStateProperty.all(Colors.grey[400]),
        foregroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor)  ,
        minimumSize: MaterialStateProperty.all(Size(120,60),
        ),
        ),
        );
  }
}
