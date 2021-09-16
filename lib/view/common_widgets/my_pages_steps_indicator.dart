import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class MyPagesStepsIndicator extends StatelessWidget {
  final String text;
  final String secondText;
  final int numberOfPages;
  final double currentPage;
  final List<String> paths = ['register.png','otp.gif','personal.png'];
   MyPagesStepsIndicator({
    Key key, this.text, this.secondText, this.numberOfPages, this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Image.asset(
                      'assets/images/${paths[currentPage.toInt()]}',
                      width: 0.7 * MediaQuery.of(context).size.width,
                    ),
    Text(
      text,
      style: TextStyle(color: Colors.black, fontSize: 36),
    ),
    Text(
     secondText,
      style: TextStyle(
          color: Theme.of(context).primaryColor, fontSize: 18),
    ),
    DotsIndicator(
      dotsCount: numberOfPages,
      position: currentPage,
      decorator: DotsDecorator(
        activeColor: Theme.of(context).primaryColor,
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)),
      ),
    ),
      ],
    );
  }
}
