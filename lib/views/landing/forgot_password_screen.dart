import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/utils/text_input/text_input.dart';
import 'package:rcore/views/landing/login_screen.dart';
import 'package:rcore/views/layouts/layout1.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  //Init variables
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
    return layout1(context, MultiLang().forgotPassword(lang), [
      textFieldWithPrefixIcon('Email', Icons.email, 'text', emailController, context, (value) {}),
      primarySizedButton(MultiLang().confirm(lang), context, () {
        if(emailController.text.isEmpty) {
          notiDialog(MultiLang().notification(lang), MultiLang().pleaseEnterYourEmail(lang), () {
            Navigator.pop(context);
          }, context);
          return;
        }
        GetAPI('https://2ndline.io/mapiv1/forgotpasswordm', context, 'POST', {
          'email': emailController.text,
          'lang': lang,
        }).then((Map<String, dynamic> json) => ({
          if(json['status'] == 1) {
            notiDialog(MultiLang().notification(lang), json['message'], () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
            }, context)
          }
          else {
            notiDialog(MultiLang().notification(lang), 'Wrong email address', () {
              Navigator.pop(context);
            }, context)
          }
        }));
      })
    ]);
  }
}