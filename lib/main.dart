import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/views/layouts/loading.dart';
import 'package:rcore/views/otp/otp_create_screen.dart';
import 'package:rcore/views/otp/otp_load_screen.dart';
import 'package:rcore/views/transaction/transaction_confirm_screen.dart';
import 'package:rcore/views/transaction/transaction_create_screen.dart';

import 'views/landing/landing_screen.dart';


void main() {
  runApp(const MyApp());
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
class MyApp extends StatelessWidget {
  const MyApp({Key    ? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2ndLine',
      theme: ThemeData(fontFamily: 'Roboto').copyWith(
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: themeColor,
      ),
      home: const LandingScreen()
    );
  }
}