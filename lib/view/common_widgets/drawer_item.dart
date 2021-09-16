import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  DrawerItem({this.icon, this.text, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: ListTile(
          onTap: onTap,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(fontSize: 16,color: Theme.of(context).primaryColor),
              ),
              Icon(icon, color: Theme.of(context).primaryColor,size: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
