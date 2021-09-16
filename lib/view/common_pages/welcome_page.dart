import 'package:flutter/material.dart';
import 'package:mask_free/view/common_widgets/my_logo.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return Container(
       decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.teal[200]])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
                        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyLogo(
                    logoPath: 'assets/images/welcome.png',
                    title: 'MaskFree',
                    secondSentence: 'منصتك الافضل لأخذ لقاح كورونا',
                  ),
                 
                  ElevatedButton(
                      style: ButtonStyle(
                        
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 0.8, 60)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                         Navigator.pushNamed(context, '/LoginPage');
                      },
                      child: Text('تسجيل الدخول')),
                      SizedBox(height: 10,),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all(Colors.white) ,
          overlayColor: MaterialStateProperty.all(Colors.grey[400]),
          foregroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor)  ,
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 0.8, 60)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                         Navigator.pushNamed(context, '/RegisterPage');
                      },
                      child: Text('انشاء حساب'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
