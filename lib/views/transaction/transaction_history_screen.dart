// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/items/home.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/views/layouts/layout2.dart';
import 'package:rcore/views/layouts/loading.dart';
import 'package:rcore/views/transaction/transaction_confirm_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreen();
}

class _TransactionHistoryScreen extends State<TransactionHistoryScreen> {
  Map<String, dynamic> userInfo = new Map();
  bool loadedInfo = false;
  String lang = '';
  bool loadedLang = false;
  String money = '0 \$';
  bool loadedMoney = false;

  List<Widget> transactionList = List<Widget>.generate(0, (index) => Container());
  bool loadedTransaction = false;

  @override
  Widget build(BuildContext context) {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    getUserInfo().then((value) => ({
      if(!loadedInfo) {
        setState(() {
          userInfo = value;
          loadedInfo = true;
        })
      }
    }));
    getLanguage().then((value) => ({
      if(!loadedLang) {
        setState(() {
          lang = value;
          loadedLang = true;
        })
      }
    }));
    
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
    if(loadedInfo && loadedLang && loadedMoney && loadedTransaction) {
      return layout2(_scaffoldKey, context, MultiLang().transactionHistory(lang), [
        Column(
          children: transactionList,
        )
      ], 'transactionHistory', userInfo, lang, money);
    }
    else {
      return loadingScreen();
    }
  }
  void getData() {
    if(loadedInfo && !loadedTransaction) {
      GetAPI('https://2ndline.io/mapiv1/GetHistoryRecharge?token=' + userInfo['token'] + '&lang=' + lang, context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        transactionList = List<Widget>
          .generate(json['data'].length, (index) => 
          itemDisplayPrefixIcon(
            getIcon(json['data'][index]['StatusCode']),
            json['data'][index]['Bank'] == null ? '' : json['data'][index]['Bank'].toString(), 
            'ID: ' + json['data'][index]['Id'].toString() + ' - Date: ' + json['data'][index]['CreatedDate'],
            MultiLang().amount(lang) + ': ' + json['data'][index]['Money'].toString() + '\$',
            () {
              SharedPreferences.getInstance().then((prefs) => ({
                prefs.remove('newTopUp'),
                prefs.setString('selectedTopUp', jsonEncode(json['data'][index]))
              }));
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionConfirmScreen()));
            },
            Icons.view_list, json['data'][index]['StatusCode'])),
        setState(() {
          loadedTransaction = true;
        })
      }));
    }
  }
}