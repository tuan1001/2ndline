// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_is_empty, avoid_init_to_null, prefer_const_constructors, prefer_collection_literals, unnecessary_new

import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/utils/list_view/horizontal.dart';
import 'package:rcore/utils/text_input/text_input.dart';
import 'package:rcore/views/layouts/layout2.dart';
import 'package:rcore/views/layouts/loading.dart';
import 'package:rcore/views/transaction/transaction_confirm_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionCreateScreen extends StatefulWidget {
  const TransactionCreateScreen({Key? key}) : super(key: key);

  @override
  State<TransactionCreateScreen> createState() => _TransactionCreateScreen();
}

class _TransactionCreateScreen extends State<TransactionCreateScreen> {
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> userInfo = new Map();
  bool loadedInfo = false;
  String lang = '';
  bool loadedLang = false;
  String money = '0 \$';
  bool loadedMoney = false;
  String amountInVND = '0';
  TextEditingController amountController = TextEditingController();

  Map<String, dynamic> bankJson = {};
  Map<String, dynamic> internationalBankJson = {};
  List<Widget> bankList = List<Widget>.generate(0, (index) => Container());
  bool loadedBank = false;
  bool isInternational = false;
  double currencyRate = 24000;
  bool loadedRate = false;

  Map<String, dynamic>? selectedBank = null;

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
    if(loadedInfo) {
      getData();
    }
    getCurrencyRate();
    if(loadedInfo && !loadedMoney) {
      GetAPI('https://2ndline.io/mapiv1/getbalance?lang=vi&token=' + userInfo['token'], context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        setState(() {
          money = json['balance'].toString() + ' \$';
          loadedMoney = true;
        })
      }));
    }
    if(loadedBank && loadedInfo && loadedLang && loadedMoney && loadedRate) {
      return layout2(_scaffoldKey, context, MultiLang().topUp(lang), [
        Text(
          MultiLang().chooseBank(lang),
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        ),
        Container(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 4/3,
            children: List<Widget>.generate(bankJson.length, (index) => TextButton(
              onPressed: () {
                setState(() {
                  selectedBank = bankJson[index.toString()];
                  isInternational = false;
                  print(selectedBank);
                });
              }, 
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 3,
                    color: selectedBank != null && selectedBank!['Code'] == bankJson[index.toString()]['Code'] ? themeColor : Colors.transparent
                  )
                ),
                child: Image.network(
                  bankJson[index.toString()]['Image']
                )
              )
            )
            ),
          ),
        ),
        Text(
          MultiLang().chooseInternationalBank(lang),
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2,
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 4/3,
            children: List<Widget>.generate(internationalBankJson.length, (index) => TextButton(
              onPressed: () {
                setState(() {
                  selectedBank = internationalBankJson[index.toString()];
                  isInternational = true;
                  print(selectedBank);
                });
              }, 
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 3,
                    color: selectedBank != null && selectedBank!['name'] == internationalBankJson[index.toString()]['name'] ? themeColor : Colors.transparent
                  )
                ),
                child: Image.network(
                  internationalBankJson[index.toString()]['img']
                )
              )
            )
            ),
          ),
        ),
        textFieldWithPrefixIcon(MultiLang().enterAmountMoney(lang), Icons.attach_money, 'number', amountController, context, (value) {
          setState(() {
            amountInVND = value.length > 0 ? NumberFormat.decimalPattern().format(double.parse(value) * 24000).toString() : '0';
          });
        }),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Text('= ' + amountInVND + ' VNĐ'),
        ),
        primarySizedButton(MultiLang().confirm(lang), context, () async {
          if(selectedBank == null) {
            notiDialog(MultiLang().notification(lang), 'Please select a bank', () {
              Navigator.pop(context);
            }, context);
            return;
          }
          if(amountController.text.isEmpty) {
            notiDialog(MultiLang().notification(lang), 'Please enter amount of money', () {
              Navigator.pop(context);
            }, context);
            return;
          }
          // if(int.parse(amountController.text) > int.parse(selectedBank!['min']) && isInternational) {
          //   notiDialog(MultiLang().notification(lang), 'Please enter amount of money', () {
          //     Navigator.pop(context);
          //   }, context);
          //   return;
          // }
          if(isInternational) {
            GetAPI('https://2ndline.io/mapiv1/CreateTopup?token=' + userInfo['token'] + "&money=" + amountController.text +"&code=" + selectedBank!['code'] + "&lang=" + lang, context, 'GET', {  }).then((Map<String, dynamic> json) => ({
              if(json['status'] == 1) {
                launchUrl(Uri.parse(json['url']))
              }
            }));
          }
          else {
            GetAPI('https://2ndline.io/mapiv1/Topup', context, 'POST', {
              'code': selectedBank!['Code'],
              'money': amountController.text,
              'token': userInfo['token'],
              'lang': lang
            }).then((Map<String, dynamic> json) => ({
              if(json['code'] == 1) {
                json['data']['amount'] = amountInVND,
                SharedPreferences.getInstance().then((prefs) => ({
                  prefs.setString('newTopUp', jsonEncode(json['data']))
                })),
                notiDialog(MultiLang().notification(lang), json['message'], () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TransactionConfirmScreen()));
                }, context)
              }
              else {
                notiDialog(MultiLang().notification(lang), json['message'], () {
                  Navigator.pop(context);
                }, context)
              }
            }));
          }
        })
      ], 'topUp', userInfo, lang, money);
    }
    else {
      return loadingScreen();
    }
  }

  void getData() {
    if(!loadedBank) {
      GetAPI('https://2ndline.io/mapiv1/GetBank', context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        setState(() {
          bankJson = json;
          loadedBank = true;
        })
      }));
      GetAPI('https://2ndline.io/mapiv1/AvailablePaymentMethod?lang=' + lang, context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        setState(() {
          internationalBankJson = json;
          loadedBank = true;
        })
      }));
    }
  }
  void getCurrencyRate() {
    if(!loadedRate) {
      GetAPI('https://2ndline.io/mapiv1/GetExchangeRate?unitName=vnd', context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        setState(() {
          currencyRate= json['rate'];
          loadedRate = true;
        })
      }));
    }
  }
}