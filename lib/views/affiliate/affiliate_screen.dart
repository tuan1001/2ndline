// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/buttons/text_button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/items/otp.dart';
import 'package:rcore/utils/items/transaction.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/utils/list_view/vertical.dart';
import 'package:rcore/utils/text_input/selection.dart';
import 'package:rcore/utils/text_input/text_input.dart';
import 'package:rcore/views/layouts/layout2.dart';

class Affiliate extends StatefulWidget {
  const Affiliate({Key? key}) : super(key: key);

  @override
  State<Affiliate> createState() => _Affiliate();
}

class _Affiliate extends State<Affiliate> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> userInfo = new Map();
  bool loadedInfo = false;
  String lang = '';
  bool loadedLang = false;
  String money = '0 \$';
  bool loadedMoney = false;

  List<dynamic>? jsonMember = null;
  bool loadedMember = false;
  List<dynamic>? jsonBank = null;
  bool loadedBank = false;

  String? bankName = null;
  String? linkInvite = '';

  String balance = '0.0\$';
  bool loadedBalance = false;

  TextEditingController emailwalletController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    if(!loadedInfo) {
      getUserInfo().then((value) => ({
        linkInvite = value['linkref'],
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
    if(loadedInfo && !loadedMember) {
      GetAPI('https://2ndline.io/mapiv1/GetJsonBonusUser', context, 'POST', {
        'token': userInfo['token'],
        'lang': lang
      }).then((Map<String, dynamic> json) => ({
        if(json['status'] == 1) {
          setState(() {
            jsonMember = json['data'];
            loadedMember = true;
          })
        }
      }));
    }
    if(loadedInfo && !loadedBank) {
      GetAPI('https://2ndline.io/mapiv1/GetJsonBankWithdraw', context, 'POST', {
        'token': userInfo['token'],
        'lang': lang
      }).then((Map<String, dynamic> json) => ({
        if(json['status'] == 1) {
          setState(() {
            jsonBank = json['data'];
            loadedBank = true;
          })
        }
      }));
    }
    if(loadedInfo && !loadedBalance) {
      GetAPI('https://2ndline.io/mapiv1/GetBalanceBonus', context, 'POST', {
        'token': userInfo['token'],
      }).then((Map<String, dynamic> json) => ({
        if(json['status'] == 1) {
          setState(() {
            balance = json['balance'].toString() + '0.0\$';
            loadedBalance = true;
          })
        }
      }));
    }
    
    return layout2(_scaffoldKey, context, MultiLang().affiliate(lang), [
      itemTransactionLine(MultiLang().affiliateLink(lang), linkInvite.toString(), () {
        Clipboard.setData(ClipboardData(text: linkInvite));
      }),
      contentWithLeadingLabel(MultiLang().balance(lang), balance),
      contentHeader(MultiLang().withdraw(lang)),
      dialogSelection(jsonBank != null && jsonBank!.length > 0 ? List<Widget>
        .generate(jsonBank!.length, (index) => itemSelect(jsonBank![index].toString(), () {
          setState(() {
            bankName = jsonBank![index].toString();
            Navigator.pop(context);
          });
        })) : [], bankName == null ? MultiLang().choostBankToWithdraw(lang) : bankName.toString(), context),
      textFieldWithPrefixIcon(MultiLang().emailwalletAddress(lang), Icons.email, 'text', emailwalletController, context, (value) {}),
      textFieldWithPrefixIcon(MultiLang().amount(lang), Icons.attach_money, 'number', amountController, context, (value) {}),
      textFieldWithPrefixIcon(MultiLang().content(lang), Icons.text_fields, 'text', contentController, context, (value) {}),
      primarySizedButton(MultiLang().withdraw(lang), context, () {
        if(bankName == null) {
          notiDialog(MultiLang().notification(lang), MultiLang().pleaseSelectABank(lang), () {
            Navigator.pop(context);
          }, context);
          return;
        }
        if(emailwalletController.text.isEmpty) {
          notiDialog(MultiLang().notification(lang), MultiLang().pleaseEnterEmailWallet(lang), () {
            Navigator.pop(context);
          }, context);
          return;
        }
        if(amountController.text.isEmpty) {
          notiDialog(MultiLang().notification(lang), MultiLang().pleaseEnterAmount(lang), () {
            Navigator.pop(context);
          }, context);
          return;
        }
        GetAPI('https://2ndline.io/mapiv1/Withdraw', context, 'POST', {
          'token': userInfo['token'],
          'lang': lang,
          'BankName': bankName,
          'wallet': emailwalletController.text,
          'Money': amountController.text,
          'content': contentController.text.isEmpty ? '' : contentController.text,
        }).then((Map<String, dynamic> json) => ({
          if(json['status'] == 1) {
            notiDialog(MultiLang().notification(lang), json['message'], () {
              setState(() {
                bankName = null;
                emailwalletController.text = '';
                amountController.text = '';
                contentController.text = '';
              });
              Navigator.pop(context);
            }, context)
          }
          else {
            notiDialog(MultiLang().notification(lang), json['message'], () {
              Navigator.pop(context);
            }, context)
          }
        }));
      }),
      contentHeader(MultiLang().member(lang)),
      verticalListView(MediaQuery.of(context).size.height - 650, jsonMember != null && jsonMember!.length > 0 ?
      List<Widget>.generate(jsonMember!.length, (index) => Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top:10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: themeColor),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Text(jsonMember![index].toString())
      )) : [])
    ], 'affiliate', userInfo, lang, money);
  }
}