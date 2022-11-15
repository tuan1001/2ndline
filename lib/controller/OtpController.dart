// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/views/otp/otp_load_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void actionCreateOTP(Map<String, dynamic> param, BuildContext context) async {
  GetAPI('https://2ndline.io/mapiv1/order', context, 'POST', param).then((Map<String, dynamic> json) => ({
    if(json['status'].toString() != '1') {
      notiDialog('', json['message'], () {
        Navigator.pop(context);
      }, context)
    }
    else {
      notiDialog('', json['message'], () async {
        var prefs = await SharedPreferences.getInstance();
        prefs.setString('selectedOrderID', json['id'].toString());
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => OtpLoadScreen())));
      }, context)
    }
  }));
}

Color getOrderStatusColor(int value) {
  switch(value) {
    case 1:
      return Colors.green;
    case 0:
      return Colors.orange;
    case -1:
      return Colors.red;
    case -2:
      return Colors.black;
    default:
      return Colors.white;
  }
}