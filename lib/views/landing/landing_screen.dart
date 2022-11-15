import 'package:flutter/material.dart';
import 'package:rcore/views/landing/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Delay(context);
    return Scaffold(
      body: (
        Align(
            alignment: Alignment.center,
            child: Image.asset(
              'lib/assets/images/main-logo.png',
              width: 300,
            )
        )
      )
    );
  }
  void Delay(BuildContext context)   {
    Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
}
