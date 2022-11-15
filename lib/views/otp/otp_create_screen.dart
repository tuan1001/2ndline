// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_init_to_null


import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rcore/controller/OtpController.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/dialogs/custom_dialog.dart';
import 'package:rcore/utils/items/otp.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/utils/text_input/checkbox.dart';
import 'package:rcore/utils/text_input/selection.dart';
import 'package:rcore/views/layouts/layout2.dart';
import 'package:rcore/views/layouts/loading.dart';
import 'package:rcore/views/otp/otp_load_screen.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpCreateScreen extends StatefulWidget {
  const OtpCreateScreen({Key? key}) : super(key: key);

  @override
  State<OtpCreateScreen> createState() => _OtpCreateScreen();
}

class _OtpCreateScreen extends State<OtpCreateScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> userInfo = new Map();
  bool loadedInfo = false;
  String lang = '';
  bool loadedLang = false;
  String money = '0 \$';
  bool loadedMoney = false;
  bool loadedCountry = false;
  bool loadedService = false;
  bool loadedOperator = false;
  bool? isUseVoiceOTP = false;

  List<DropdownMenuItem<Map<String, dynamic>>> countryList = [];
  List<DropdownMenuItem<Map<String, dynamic>>> serviceList = [];
  List<DropdownMenuItem<Map<String, dynamic>>> operatorList = [];

  Map<String, dynamic> selectedCountry = Map();
  Map<String, dynamic> selectedService = Map();
  Map<String, dynamic> selectedOperator = Map();
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
    //Country
    if(!loadedCountry) {
      GetAPI('https://2ndline.io/mapiv1/availablecountry', context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        countryList = List<DropdownMenuItem<Map<String, dynamic>>>.generate(json.length, (index) => 
          DropdownMenuItem(
            value: json[index.toString()],
            child: itemCountrySelect(json[index.toString()]['img'], json[index.toString()]['name'], () {
              setState(() {
                loadedService = false;
                loadedOperator = false;
                selectedCountry = json[index.toString()];
                Navigator.pop(context);
              });
            }),
          )),
        setState(() {
          loadedCountry = true;
        })
      }));
    }
    //Service
    if(loadedCountry && !loadedService) {
      GetAPI('https://2ndline.io/mapiv1/AvailableService?countryId=' + (selectedCountry.isEmpty ? '' : selectedCountry['countryId'].toString()), context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        serviceList = List<DropdownMenuItem<Map<String, dynamic>>>.generate(json.length, (index) => 
          DropdownMenuItem(
            value: json[index.toString()],
            child: itemSelect(json[index.toString()]['name'] + ' - ' + json[index.toString()]['price'].toString() + '\$ - ' + json[index.toString()]['lockTime'].toString() + ' ' + MultiLang().minutes(lang), () {
              setState(() {
                selectedService = json[index.toString()];
                Navigator.pop(context);
              });
            }),
          )),
        setState(() {
          loadedService = true;
        })
      }));
    }
    //Operator
    if(loadedCountry && !loadedOperator) {
      GetAPI('https://2ndline.io/mapiv1/AvailableOperator?countryId=' + (selectedCountry.isEmpty ? '' : selectedCountry['countryId'].toString()), context, 'GET', {})
      .then((Map<String, dynamic> json) => ({
        operatorList = List<DropdownMenuItem<Map<String, dynamic>>>.generate(json.length, (index) => 
          DropdownMenuItem(
            value: json[index.toString()],
            child: itemSelect(json[index.toString()]['name'], () {
              setState(() {
                selectedOperator = json[index.toString()];
                Navigator.pop(context);
              });
            }),
          )),
        setState(() {
          loadedOperator = true;
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
    if(loadedCountry && loadedInfo && loadedLang && loadedMoney && loadedOperator && loadedService) {
      return layout2(_scaffoldKey, context, MultiLang().createOtp(lang), [
        selectTwoNhaLam(selectedCountry['name'] == null ? MultiLang().chooseCountry(lang) : selectedCountry['name'] , countryList, context),
        selectTwoNhaLam(selectedService['name'] == null ? MultiLang().chooseService(lang) : selectedService['name'] , serviceList, context),
        selectTwoNhaLam(selectedOperator['name'] == null ? MultiLang().chooseOperator(lang) : selectedOperator['name'] , operatorList, context),
        squareCheckBoxWithLabel(MultiLang().useVoiceOTP(lang) + ' ' + (selectedService['priceCall'] != null ? 'Price: ' + selectedService['priceCall'].toString() + '\$' : ''), context, (bool? value) {
          setState(() {
            isUseVoiceOTP = value;
          });
        }, isUseVoiceOTP),
        primarySizedButton(MultiLang().confirm(lang), context, () async {
          var prefs = await SharedPreferences.getInstance();
          prefs.setString('nameService', selectedCountry['name']);
          actionCreateOTP({
            'token': userInfo['token'],
            'countryId': selectedCountry['countryId'].toString(),
            'serviceId': selectedService['serviceId'].toString(),
            'allowVoiceSms': isUseVoiceOTP.toString(),
            'lang': lang,
            'operatorId': selectedOperator['selectedOperator'].toString()
          }, context);
        })
      ], 'otpCreate', userInfo, lang, money);
    }
    else {
      return loadingScreen();
    }
  }
}