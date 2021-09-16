import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class MyQRcodeContainer extends StatefulWidget {
  final String text;
   
  const MyQRcodeContainer({Key key, this.text}) : super(key: key);

  @override
  _MyQRcodeContainerState createState() => _MyQRcodeContainerState();
}

class _MyQRcodeContainerState extends State<MyQRcodeContainer> {
  @override
  void initState() {
    qetQRbytes ();
    super.initState();
  }
   Uint8List _bytes;
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: _bytes == null ? Container () :Container(
          width: MediaQuery.of(context).size.width*0.35,
          height: MediaQuery.of(context).size.width*0.35,
          child: Image.memory(_bytes)),
      ),
    );
  }

  void qetQRbytes () async {
    var temp = await scanner.generateBarCode(widget.text);
    setState(() {
             _bytes = temp;
    });

   
  }
}