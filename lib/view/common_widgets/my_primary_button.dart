import 'package:flutter/material.dart';

class MyPrimaryButton extends StatelessWidget {
  const MyPrimaryButton({
    this.onPressed,
    this.text,
    this.isEnabled,
  });

  final Function onPressed;
  final bool isEnabled;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          Size(160, 60),
        ),
        backgroundColor: MaterialStateProperty.all(
          (isEnabled == null || isEnabled)
              ? Theme.of(context).primaryColor
              : Colors.grey,
        ),
      ),
    );
  }
}
