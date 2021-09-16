import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class MyLogo extends StatelessWidget {
  final String logoPath;
  final String title;
  final String secondSentence;
  const MyLogo({
    Key key,
    this.logoPath,
    this.title,
    this.secondSentence,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),

            Image.asset(
              logoPath,
              width: 0.7 * MediaQuery.of(context).size.width,
            ),
        Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                      Text ('',style: TextStyle( fontSize: 42.0,),),
                     DefaultTextStyle(
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 42.0,
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  title,
                  textStyle: TextStyle(color: Colors.teal[700],fontFamily: 'Cairo'),
                  speed: Duration(milliseconds: 200),
                  cursor: ' ',
                ),
                FlickerAnimatedText(title
                ,
                  textStyle: TextStyle(color: Colors.teal[700], fontFamily: 'Cairo'),
                )
              ],
            ),
          ),
                  ]),
        Text(
          secondSentence,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),
        ),
      ],
    );
  }
}
