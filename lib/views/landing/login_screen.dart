// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/buttons/text_button.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/utils/text_input/checkbox.dart';
import 'package:rcore/utils/text_input/text_input.dart';
import 'package:rcore/views/landing/forgot_password_screen.dart';
import 'package:rcore/views/landing/register_screen.dart';
import 'package:rcore/views/layouts/layout1.dart';
import 'package:rcore/views/otp/otp_history_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  GlobalKey loadingDialogKey = GlobalKey();
  // Init Variable
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? checkBoxValue = false;
  String lang = '';
  bool loadedLang = false;
    String assetLangIcon = 'lib/assets/icons/flag-vi.png';

  @override
  Widget build(BuildContext context) {
    getLanguage().then((value) => ({
      if(!loadedLang) {
        setState(() {
          lang = value;
          assetLangIcon = 'lib/assets/icons/flag-' + value +'.png';
          loadedLang = true;
        })
      }
    }));
    return layout1(context, MultiLang().login(lang), [
      Container(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.centerRight,
          child: PopupMenuButton(
            itemBuilder: (context) => [
              buildPopUpMenuItem('vi', 'lib/assets/icons/flag-vi.png'),
              buildPopUpMenuItem('ru', 'lib/assets/icons/flag-ru.png'),
              buildPopUpMenuItem('th', 'lib/assets/icons/flag-th.png'),
              buildPopUpMenuItem('in', 'lib/assets/icons/flag-in.png'),
              buildPopUpMenuItem('cn', 'lib/assets/icons/flag-cn.png'),
              buildPopUpMenuItem('en', 'lib/assets/icons/flag-en.png'),
            ],
            child: Row(
              children: [
                Image.asset(
                  assetLangIcon,
                  height: 15,
                ),
                Text(
                  ' ' + lang.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  )
                )
              ]
            ),
          )
           
        ),
      ),
      textFieldWithPrefixIcon(MultiLang().username(lang), Icons.account_box, 'text',usernameController, context, (value) {}),
      textFieldWithPrefixIcon(MultiLang().password(lang), Icons.lock, 'password',passwordController, context, (value) {}),
      // squareCheckBoxWithLabel(MultiLang().saveAccount(lang), context, (bool? value) => {
      //   setState(() {
      //     checkBoxValue = value;
      //   })
      // }, checkBoxValue),
      primarySizedButton(MultiLang().login(lang), context, () {
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
        showDialog(context: context, builder: (context) => Dialog(
          key: loadingDialogKey,
          child: Image.asset(
            'lib/assets/images/loading.gif',
          ),
        ));
        GetAPI('https://2ndline.io/mapiv1/loginm', context, 'POST', {
          'username': usernameController.text,
          'password': passwordController.text,
        }).then((Map<String, dynamic> json) => ({
          if(json['status'].toString() == 'true') {
            GetAPI('https://2ndline.io/mapiv1/getinfo', context, 'POST', {
              'token': json['data']['token'],
            }).then((Map<String, dynamic> user) => ({
              Navigator.pop(context),
              user['data']['token'] = json['data']['token'],
              user['data']['fullName'] = json['data']['fullName'],
              SharedPreferences.getInstance().then((prefs) => ({
                 prefs.setString('infoUser', jsonEncode(user['data'])),
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OtpHistoryScreen()))
              }))
              // notiDialog('', json['message'], () async {
              //   var prefs = await SharedPreferences.getInstance();
              //   await prefs.setString('infoUser', jsonEncode(user['data']));
              //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OtpHistoryScreen()));
              // }, context)
            })),
          }
          else {
            notiDialog('', json['message'], () {
              Navigator.pop(context);
              Navigator.pop(context);
            }, context)
          }
        }));
      }),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          defaultTextButton(MultiLang().register(lang), () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterScreen()));
          }),
          defaultTextButton(MultiLang().forgotPassword(lang), () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
          }),
        ],
      )
    ]);
  }
  PopupMenuItem buildPopUpMenuItem(String name, String assets) {
    return PopupMenuItem(
      onTap: () {
        setState(() {
          updateLanguage(name);
          lang = name;
          assetLangIcon = assets;
          loadedLang = false;
        });
      },
      child: Row(
        children: [
          Image.asset(
            assets,
            height: 15,
          ),
          Text(
            name.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            )
          )
        ]
      ),
    );
  }
}
