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

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> userInfo = new Map();
  bool loadedInfo = false;
  String lang = '';
  bool loadedLang = false;
  String money = '0 \$';
  bool loadedMoney = false;

  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    if(!loadedInfo) {
      getUserInfo().then((value) => ({
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
          money = json['balance'].toString() + ' \$';
          loadedMoney = true;
        })
      }));
    }
    if(loadedInfo && loadedLang && loadedMoney) {
      return layout2(_scaffoldKey, context, MultiLang().changePassword(lang), [
        textFieldWithPrefixIcon(MultiLang().oldPassword(lang), Icons.lock, 'password', oldPassController, context, (value) {}),
        textFieldWithPrefixIcon(MultiLang().newPassword(lang), Icons.lock, 'password', newPassController, context, (value) {}),
        textFieldWithPrefixIcon(MultiLang().confirmNewPassword(lang), Icons.lock, 'password', confirmPassController, context, (value) {}),
        primarySizedButton(MultiLang().confirm(lang), context, () {
          if(oldPassController.text.isEmpty) {
            notiDialog(MultiLang().notification(lang), MultiLang().pleaseEnterPassword(lang), () {
              Navigator.pop(context);
            }, context);
            return;
          }
          if(newPassController.text.isEmpty) {
            notiDialog(MultiLang().notification(lang), MultiLang().pleaseEnterNewPassword(lang), () {
              Navigator.pop(context);
            }, context);
            return;
          }
          if(confirmPassController.text.isEmpty) {
            notiDialog(MultiLang().notification(lang), MultiLang().pleaseConfirmPassword(lang), () {
              Navigator.pop(context);
            }, context);
            return;
          }
          if(newPassController.text != confirmPassController.text) {
            notiDialog(MultiLang().notification(lang), MultiLang().confirmPasswordFailed(lang), () {
              Navigator.pop(context);
            }, context);
            return;
          }
          GetAPI('https://2ndline.io/mapiv1/ChangePass', context, 'POST', {
            'token': userInfo['token'],
            'OldPassword': oldPassController.text,
            'NewPassword': newPassController.text,
          }).then((Map<String, dynamic> json) => ({
            if(json['status'] == 1) {
              notiDialog(MultiLang().notification(lang), 'Success', () {
                setState(() {
                  oldPassController.text = '';
                  newPassController.text = '';
                  confirmPassController.text = '';
                });
                Navigator.pop(context);
              }, context)
            }
            else {
              notiDialog(MultiLang().notification(lang), 'Wrong password', () {
                Navigator.pop(context);
              }, context)
            }
          }));
        })
      ], 'changePassword', userInfo, lang, money);
    }
    else {
      return loadingScreen();
    }
  }
}