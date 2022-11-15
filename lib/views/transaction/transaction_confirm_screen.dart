// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/items/transaction.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/views/layouts/layout2.dart';
import 'package:rcore/views/layouts/loading.dart';
import 'package:rcore/views/transaction/transaction_history_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionConfirmScreen extends StatefulWidget {
  const TransactionConfirmScreen({Key? key}) : super(key: key);

  @override
  State<TransactionConfirmScreen> createState() => _TransactionConfirmScreen();
}

class _TransactionConfirmScreen extends State<TransactionConfirmScreen> {
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> userInfo = new Map();
  bool loadedInfo = false;
  String lang = '';
  bool loadedLang = false;
  String money = '0 \$';
  bool loadedMoney = false;

  Map<String, dynamic> data = new Map();
  bool loadedData = false;

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
    getData();
    if(loadedInfo && !loadedMoney) {
      GetAPI('https://2ndline.io/mapiv1/getbalance?lang=vi&token=' + userInfo['token'], context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        setState(() {
          money = json['balance'].toString() + ' \$';
          loadedMoney = true;
        })
      }));
    }
    if(loadedData && loadedInfo && loadedLang && loadedMoney) {
      return layout2(_scaffoldKey, context, 'Top-up', [
        Text(
          MultiLang().taskID(lang),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold
          )
        ),
        Text(
          data['taskid'].toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            color: Colors.green,
            fontWeight: FontWeight.bold
          )
        ),
        Text(
          MultiLang().transactionMesssage(lang),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          )
        ),

        itemTransactionLine(MultiLang().bank(lang), data['bankname'].toString(), () {
          Clipboard.setData(ClipboardData(text: data['bankname'].toString()));
        }),
        itemTransactionLine(MultiLang().accountHolder(lang), data['accountholder'].toString(), () {
          Clipboard.setData(ClipboardData(text: data['accountholder'].toString()));
        }),
        itemTransactionLine(MultiLang().accountNumber(lang), data['accountnumber'].toString(), () {
          Clipboard.setData(ClipboardData(text: data['accountnumber'].toString()));
        }),
        itemTransactionLine(MultiLang().transferContent(lang), data['content'].toString(), () {
          Clipboard.setData(ClipboardData(text: data['content'].toString()));
        }),
        itemTransactionLine(MultiLang().amountToTransfer(lang), data['amount'].toString(), () {
          Clipboard.setData(ClipboardData(text: data['amount'].toString()));
        }),
        data['StatusCode'] == 0 ?dangerSizedButton(MultiLang().cancel(lang), context, () {
          yesNoDialog(MultiLang().notification(lang), MultiLang().doYouWantToCancelTransaction(lang), () {
            GetAPI('https://2ndline.io/mapiv1/CancelOrder', context, 'POST', {
              'id': data['taskid'].toString(),
              'token': userInfo['token']
            }).then((Map<String, dynamic> json) => ({
              if(json['code'] == 1) {
                notiDialog(MultiLang().notification(lang), json['message'], () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TransactionHistoryScreen()));
                }, context)
              }
              else {
                notiDialog(MultiLang().notification(lang), json['message'], () {
                  Navigator.pop(context);
                }, context)
              }
            }));
          }, () {
            Navigator.pop(context);
          }, context);
        }) : Container(),
      ], '', userInfo, lang, money);
    }
    else {
      return loadingScreen();
    }
  }

  void getData() async {
    if(!loadedData) {
      var prefs = await SharedPreferences.getInstance();
      String? json = await prefs.getString('newTopUp');
      if(json != null) {
        setState(() {
          data = jsonDecode(json);
          loadedData = true;
        });
      }
      else {
        String? jsonData = await prefs.getString('selectedTopUp');
        if(jsonData != null) {
          Map<String, dynamic> tempJson = jsonDecode(jsonData);
          setState(() {
            data = {
              'taskid': tempJson['Id'],
              'bankname': tempJson['Bank'],
              'accountholder': tempJson['UserPayment'],
              'accountnumber': tempJson['BankNumber'],
              'content': tempJson['Content'],
              'StatusCode': tempJson['StatusCode'],
              'amount': NumberFormat().format(tempJson['Money'] * 24000) + ' VNĐ' ,
            };
            loadedData = true;
          });
        }
      }
    }
  }
}