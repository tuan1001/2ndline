import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/items/home.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/views/layouts/layout2.dart';
import 'package:rcore/views/layouts/loading.dart';
import 'package:rcore/views/numbers/number_create_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumberHoldingScreen extends StatefulWidget {
  const NumberHoldingScreen({Key? key}) : super(key: key);

  @override
  State<NumberHoldingScreen> createState() => _NumberHoldingScreen();
}

class _NumberHoldingScreen extends State<NumberHoldingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> userInfo = new Map();
  bool loadedInfo = false;
  String lang = '';
  bool loadedLang = false;
  String money = '0 \$';
  bool loadedMoney = false;

  List<Widget> numberList = List<Widget>.generate(0, (index) => Container());
  bool loadedNumber = false;

  @override
  Widget build(BuildContext context) {
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
    
    if(loadedInfo && !loadedMoney) {
      GetAPI('https://2ndline.io/mapiv1/getbalance?lang=vi&token=' + userInfo['token'], context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        setState(() {
          money = json['balance'].toString() + ' \$';
          loadedMoney = true;
        })
      }));
    }
    getData();
    if(loadedInfo && loadedLang && loadedMoney && loadedNumber) {
      return layout2(_scaffoldKey, context,  MultiLang().holdingNumber(lang), [
        Column(
          children: numberList,
        )
      ], 'holdingNumber', userInfo, lang, money);
    }
    else {
      return loadingScreen();
    }
  }

  void getData() async {
    if(loadedInfo && !loadedNumber) {
      GetAPI('https://2ndline.io/mapiv1/Availablephone?token=' + userInfo['token'], context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        numberList = List<Widget>.generate(json['data'].length, (index) => 
        itemDisplay(json['data'][index]['phone'],
        '',
        MultiLang().timeLeft(lang) + ': ' + (json['data'][index]['time'] / 60).toStringAsFixed(1), 
        () async {
          var prefs = await SharedPreferences.getInstance();
          await prefs.setString('selectedNumber', json['data'][index]['phone']);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NumberCreateScreen()));
        },
        Icons.add, -2)),
        setState(() {
          loadedNumber = true;
        })
      }));
    }
  }
}