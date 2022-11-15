// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/buttons/text_button.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/utils/text_input/text_input.dart';
import 'package:rcore/views/landing/forgot_password_screen.dart';
import 'package:rcore/views/landing/login_screen.dart';
import 'package:rcore/views/layouts/layout1.dart';
import 'package:rcore/views/otp/otp_history_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  // Init variable
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String lang = '';
  bool loadedLang = false;
  @override
  Widget build(BuildContext context) {
    getLanguage().then((value) => ({
      if(!loadedLang) {
        setState(() {
          lang = value;
          loadedLang = true;
        })
      }
    }));
    return layout1(context, MultiLang().register(lang), [
      textFieldWithPrefixIcon(MultiLang().fullName(lang), Icons.account_circle , 'text', fullNameController, context, (value) {}),
      textFieldWithPrefixIcon(MultiLang().username(lang), Icons.account_circle, 'text', usernameController, context, (value) {}),
      textFieldWithPrefixIcon(MultiLang().password(lang), Icons.lock, 'password', passwordController, context, (value) {}),
      textFieldWithPrefixIcon(MultiLang().confirmPassword(lang), Icons.lock, 'password', confirmPasswordController, context, (value) {}),
      textFieldWithPrefixIcon(MultiLang().phoneNumber(lang), Icons.phone, 'number', phoneNumberController, context, (value) {}),
      textFieldWithPrefixIcon('Email', Icons.email, 'text', emailController, context, (value) {}),
      primarySizedButton(MultiLang().register(lang), context, () {
        if(fullNameController.text.isEmpty) {
          notiDialog(MultiLang().notification(lang), MultiLang().pleaseEnterYourName(lang), () {
            Navigator.pop(context);
          }, context);
          return;
        }
        if(usernameController.text.isEmpty) {
          notiDialog(MultiLang().notification(lang), MultiLang().pleaseEnterUsername(lang), () {
            Navigator.pop(context);
          }, context);
          return;
        }
        if(passwordController.text.isEmpty) {
          notiDialog(MultiLang().notification(lang), MultiLang().pleaseEnterPassword(lang), () {
            Navigator.pop(context);
          }, context);
          return;
        }
        if(confirmPasswordController.text.isEmpty) {
          notiDialog(MultiLang().notification(lang), MultiLang().pleaseConfirmPassword(lang), () {
            Navigator.pop(context);
          }, context);
          return;
        }
        if(confirmPasswordController.text != passwordController.text) {
          notiDialog(MultiLang().notification(lang), MultiLang().confirmPasswordFailed(lang), () {
            Navigator.pop(context);
          }, context);
          return;
        }
        if(phoneNumberController.text.isEmpty) {
          notiDialog(MultiLang().notification(lang), MultiLang().pleaseEnterYourPhoneNumber(lang), () {
            Navigator.pop(context);
          }, context);
          return;
        }
        if(emailController.text.isEmpty) {
          notiDialog(MultiLang().notification(lang), MultiLang().pleaseEnterYourEmail(lang), () {
            Navigator.pop(context);
          }, context);
          return;
        }
        if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)) {
          notiDialog(MultiLang().notification(lang), MultiLang().emailFormatIsNotCorrent(lang), () {
            Navigator.pop(context);
          }, context);
          return;
        }
        showDialog(context: context, builder: (context) => Dialog(
          child: Image.asset(
            'lib/assets/images/loading.gif',
          ),
        ));
        GetAPI('https://2ndline.io/mapiv1/registerm', context, 'POST', {
          'Username': usernameController.text,
          'Password': passwordController.text,
          'Phone': phoneNumberController.text,
          'FullName': fullNameController.text,
          'Email': emailController.text,
        }).then((Map<String, dynamic> json) => ({
          Navigator.of(context).pop(),
          if(json['status'].toString() == '1') {
            notiDialog(MultiLang().notification(lang), json['message'], () async {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => LoginScreen())));
            }, context)
          }
          else {
            notiDialog(MultiLang().notification(lang), json['message'].toString().split(',').first, () {
              Navigator.pop(context);
            }, context)
          }
        }));
      }),
      defaultTextButton(MultiLang().alreadyHaveAccount(lang), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
      })
    ]);
  }
}