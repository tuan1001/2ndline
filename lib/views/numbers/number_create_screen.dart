// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rcore/controller/OtpController.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/items/otp.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/utils/text_input/checkbox.dart';
import 'package:rcore/utils/text_input/selection.dart';
import 'package:rcore/views/layouts/layout2.dart';
import 'package:rcore/views/layouts/loading.dart';
import 'package:rcore/views/otp/otp_load_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumberCreateScreen extends StatefulWidget {
  const NumberCreateScreen({Key? key}) : super(key: key);

  @override
  State<NumberCreateScreen> createState() => _NumberCreateScreen();
}

class _NumberCreateScreen extends State<NumberCreateScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> userInfo = new Map();
  bool loadedInfo = false;
  String lang = '';
  bool loadedLang = false;
  String money = '0 \$';
  bool loadedMoney = false;
  List<Widget> countryList = List<Widget>.generate(0, (index) => Container());
  bool loadedCountry = false;
  List<Widget> serviceList = List<Widget>.generate(0, (index) => Container());
  bool loadedService = false;
  List<Widget> operatorList = List<Widget>.generate(0, (index) => Container());
  bool loadedOperator = false;
  bool? isUseVoiceOTP = false;
  String number = '';
  bool loadedNumber = false;
 
  Map<String, dynamic>? selectedCountry = null;
  Map<String, dynamic>? selectedService = null;
  Map<String, dynamic>? selectedOperator = null;
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
    getNumber();
    //Country
    if(!loadedCountry) {
      GetAPI('https://2ndline.io/mapiv1/availablecountry', context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        countryList = List<Widget>.generate(json.length, (index) => 
          itemCountrySelect(json[index.toString()]['img'], json[index.toString()]['name'], () {
            setState(() {
              loadedService = false;
              loadedOperator = false;
              selectedCountry = json[index.toString()];
              Navigator.pop(context);
            });
          }) 
        ),
        setState(() {
          loadedCountry = true;
        })
      }));
    }
    //Service
    if(!loadedService) {
      GetAPI('https://2ndline.io/mapiv1/AvailableService?countryId=' + (selectedCountry == null ? '' : selectedCountry!['countryId'].toString()), context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        serviceList = List<Widget>.generate(json.length, (index) => 
          itemSelect(json[index.toString()]['name'], () {
            setState(() {
              selectedService = json[index.toString()];
              Navigator.pop(context);
            });
          }) 
        ),
        setState(() {
          loadedService = true;
        })
      }));
    }
    //Operator
    if(!loadedOperator) {
      GetAPI('https://2ndline.io/mapiv1/AvailableOperator?countryId=' + (selectedCountry == null ? '' : selectedCountry!['countryId'].toString()), context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        operatorList = List<Widget>.generate(json.length, (index) => 
          itemSelect(json[index.toString()]['name'], () {
            setState(() {
              selectedOperator = json[index.toString()];
              Navigator.pop(context);
            });
          }) 
        ),
        setState(() {
          loadedOperator = true;
        })
      }));
    }
    if(loadedInfo && loadedCountry && loadedLang && loadedMoney && loadedNumber && loadedOperator && loadedService) {
      return layout2(_scaffoldKey, context, MultiLang().createOtp(lang), [
        Text(
          MultiLang().yourPhoneNumber(lang),
          style: TextStyle(
            fontSize: 26,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          number,
          style: TextStyle(
            fontSize: 26,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        dialogSelection(countryList, selectedCountry == null ? MultiLang().chooseCountry(lang) : selectedCountry!['name'], context),
        dialogSelection(serviceList, selectedService == null ? MultiLang().chooseService(lang) : selectedService!['name'], context),
        dialogSelection(operatorList, selectedOperator == null ? MultiLang().chooseOperator(lang) : selectedOperator!['name'], context),
        squareCheckBoxWithLabel(MultiLang().useVoiceOTP(lang), context, (bool? value) {
          setState(() {
            isUseVoiceOTP = value;
          });
        }, isUseVoiceOTP),
        primarySizedButton(MultiLang().confirm(lang), context, () async {
          GetAPI('https://2ndline.io/mapiv1/OrderByPhone', context, 'POST', {
            'token': userInfo['token'],
            'phone': number.toString(),
            'serviceId': selectedService!['serviceId'].toString(),
            'allowVoiceSms': isUseVoiceOTP.toString(),
            'lang': lang
          }).then((Map<String, dynamic> json) => ({
            if(json['status'] == 1) {
              SharedPreferences.getInstance().then((prefs) => ({
                prefs.setString('selectedOrderID', json['id'].toString())
              })),
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OtpLoadScreen()))
            }
            else {
              notiDialog(MultiLang().notification(lang), json['message'], () {
                Navigator.pop(context);
              }, context)
            }
          }));
        })
      ], 'otpCreate', userInfo, lang, money);
    }
    else {
      return loadingScreen();
    }
    }

  void getNumber() async {
    if(!loadedNumber) {
      var prefs = await SharedPreferences.getInstance();
      String? num = await prefs.getString('selectedNumber');
      number = num == null ? '' : num;
      setState(() {
        loadedNumber = true;
      });
    }
  }
}