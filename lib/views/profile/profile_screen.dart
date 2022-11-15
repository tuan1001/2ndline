import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/utils/text_input/text_input.dart';
import 'package:rcore/views/layouts/layout2.dart';
import 'package:rcore/views/layouts/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> userInfo = new Map();
  bool loadedInfo = false;
  String lang = '';
  bool loadedLang = false;
  String money = '0 \$';
  bool loadedMoney = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    if(!loadedInfo) {
      getUserInfo().then((value) => ({
          nameController.text = value['fullName'] == null ? '' : value['fullName'],
          phoneController.text = value['phone'] == null ? '' : value['phone'],
          emailController.text = value['email'] == null ? '' : value['email'],
          addressController.text = value['address'] == null ? '' : value['address'],
          setState(() {
            userInfo = value;
            loadedInfo = true;
          })
      }));
    }
    if(!loadedLang) {
      getLanguage().then((value) => ({
          setState(() {
            lang = value;
            loadedLang = true;
          })
      }));
    }
   
    if(loadedInfo && !loadedMoney) {
      GetAPI('https://2ndline.io/mapiv1/getbalance?lang=vi&token=' + userInfo['token'], context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        setState(() {
          money = json['balance'] == null ? '0\$' : json['balance'].toString() + ' \$';
          loadedMoney = true;
        })
      }));
    }
    if(loadedInfo && loadedLang && loadedMoney) {
      return layout2(_scaffoldKey, context, MultiLang().profile(lang), [
        textFieldWithPrefixIcon(MultiLang().fullName(lang), Icons.account_circle, 'text', nameController, context, (value) {}),
        textFieldWithPrefixIcon(MultiLang().phoneNumber(lang), Icons.phone, 'number', phoneController, context, (value) {}),
        textFieldWithPrefixIcon('Email', Icons.email, 'text', emailController, context, (value) {}),
        textFieldWithPrefixIcon(MultiLang().address(lang), Icons.home, 'text', addressController, context, (value) {}),
        primarySizedButton(MultiLang().save(lang), context, () {
          if(nameController.text.isEmpty) {
              notiDialog(MultiLang().notification(lang), MultiLang().pleaseEnterYourName(lang), () {
                Navigator.pop(context);
              }, context);
              return;
          }
          if(phoneController.text.isEmpty) {
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
          GetAPI('https://2ndline.io/mapiv1/changeinfo', context, 'POST', {
            'token': userInfo['token'],
            'fullnane': nameController.text,
            'phone': phoneController.text,
            'email': emailController.text,
            'address': addressController.text.isEmpty ? '' : addressController.text,
          }).then((Map<String, dynamic> json) => ({
            if(json['status'] == 1) {
              userInfo['fullName'] = nameController.text,
              userInfo['phone'] = phoneController.text,
              userInfo['email'] = emailController.text,
              userInfo['address'] = addressController.text,
              SharedPreferences.getInstance().then((prefs) => ({
                prefs.setString('infoUser', jsonEncode(userInfo))
              })),
              notiDialog(MultiLang().notification(lang), 'Success', () {
                setState(() {
                  loadedInfo = false;
                });
                Navigator.pop(context);
              }, context)
            }
            else {
              notiDialog(MultiLang().notification(lang), 'Failed', () {
                Navigator.pop(context);
              }, context)
            }
          }));
        })
      ], '', userInfo, lang, money);
    }
    else {
      return loadingScreen();
    }
  }
}