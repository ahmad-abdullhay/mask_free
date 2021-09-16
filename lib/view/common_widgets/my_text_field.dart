import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final Function validator;
  final Function onChange;
  final String hintText;
  final TextInputType textInputType;
  final bool isObscure;
  final IconData iconData;
  const MyTextField({
    Key key,
    this.validator,
    this.hintText,
    this.textInputType,
    this.isObscure,
    this.iconData,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:14.0),
      child: TextFormField(
        style: TextStyle(fontSize: 16.0),
        validator: validator,
        obscureText: isObscure ?? false,
        textAlign: TextAlign.center,
        keyboardType: textInputType,
        onChanged: onChange,
        decoration: InputDecoration(labelText: hintText, icon: Icon(iconData)),
      ),
    );
  }
}
