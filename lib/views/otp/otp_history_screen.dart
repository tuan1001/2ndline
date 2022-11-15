// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously, avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rcore/controller/OtpController.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/custom_dialog.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/items/home.dart';
import 'package:rcore/utils/items/otp.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/utils/text_input/checkbox.dart';
import 'package:rcore/utils/text_input/selection.dart';
import 'package:rcore/views/layouts/layout2.dart';
import 'package:rcore/views/layouts/loading.dart';
import 'package:rcore/views/numbers/number_create_screen.dart';
import 'package:rcore/views/otp/otp_load_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpHistoryScreen extends StatefulWidget {
  const OtpHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OtpHistoryScreen> createState() => _OtpHistoryScreen();
}

class _OtpHistoryScreen extends State<OtpHistoryScreen> {
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
  bool loadedNumber = false;
  bool? isUseVoiceOTP = false;

  List<DropdownMenuItem<Map<String, dynamic>>> countryList = [];
  List<DropdownMenuItem<Map<String, dynamic>>> serviceList = [];
  List<DropdownMenuItem<Map<String, dynamic>>> operatorList = [];

  Map<String, dynamic>? jsonOrder = null;

  List<Widget> numberList = List<Widget>.generate(0, (index) => Container());

  Map<String, dynamic> selectedCountry = Map();
  Map<String, dynamic> selectedService = Map();
  Map<String, dynamic> selectedOperator = Map();

  
  Map<String, dynamic>? holdTimeList = null;
  bool loadedHoldTime = false;

  List<Widget> listOrder = List<Widget>.generate(0, (index) => Container());
  bool loadedOrder = false;
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
    if(loadedInfo && !loadedNumber) {
      GetAPI('https://2ndline.io/mapiv1/HistoryKeepSim', context, 'POST', {
        'token': userInfo['token'],
        'lang': lang,
      })  
      .then((Map<String, dynamic> json) => ({
        numberList = List<Widget>.generate(json['data'].length, (index) => 
        itemDisplay('${json['data'][index]['Phone']}',
        '[${json['data'][index]['Id']}] ${json['data'][index]['Date']}',
        MultiLang().expireDaate(lang) + ': ' + json['data'][index]['Exprire'], 
        () async {
          showDialog(
            context: context, 
            builder: (context) => Dialog(
              child: Container(
                padding: EdgeInsets.all(10),
                height: 300,
                child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(holdTimeList!.length, (index) => Container(
                      child: TextButton(
                        onPressed: () {
                          GetAPI('https://2ndline.io/mapiv1/Extend', context, 'POST', {
                            'token': userInfo['token'],
                            'id': json['data'][index]['Id'].toString(),
                            'time': holdTimeList![index.toString()]['time'].toString(),
                            'unit': holdTimeList![index.toString()]['timeUnit'].toString(),
                            'lang': lang,
                          }).then((Map<String, dynamic> res) => ({
                            notiDialog(MultiLang().notification(lang), res['message'], () {
                              loadedNumber = false;
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, context),
                          }));
                        }, 
                        child: Text('${holdTimeList![index.toString()]['time']} ${holdTimeList![index.toString()]['timeUnit']} - \$${holdTimeList![index.toString()]['price']}')
                      ),
                    )),
                  ),
              )
              
            )
          );
        },
        Icons.timelapse, -2)),
        setState(() {
          loadedNumber = true;
        })
      }));
    }
    if(!loadedHoldTime) {
      GetAPI('https://2ndline.io/mapiv1/AvailableTime', context, 'GET', {}).then((Map<String, dynamic> json) => ({
        holdTimeList = json,
        loadedHoldTime = true,
      }));
    }
    if(loadedOrder) {
      Delay();
    }
    if(loadedCountry && loadedInfo && loadedLang && loadedMoney && loadedOperator && loadedService) {
      return layout2(_scaffoldKey, context, MultiLang().otpOrderHistory(lang), [
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
           GetAPI('https://2ndline.io/mapiv1/order', context, 'POST', {
            'token': userInfo['token'],
            'countryId': selectedCountry['countryId'].toString(),
            'serviceId': selectedService['serviceId'].toString(),
            'allowVoiceSms': isUseVoiceOTP.toString(),
            'lang': lang,
            'operatorId': selectedOperator['selectedOperator'].toString()
          }).then((Map<String, dynamic> json) => ({
            if(json['status'].toString() != '1') {
              notiDialog('', json['message'], () {
                Navigator.pop(context);
              }, context)
            }
            else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(MultiLang().orderCreateSuccess(lang)))),
                setState(() {
                  loadedOrder = false;
                }),
            }
          }));
        }),
        Divider(
          color: Colors.grey,
        ),
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 15),
          child: Text(
            MultiLang().holdingNumber(lang).toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              color: themeColor,
              fontWeight: FontWeight.bold
            )
          ),
        ),
        Column(
          children: numberList,
        ),
        Divider(
          color: Colors.grey,
        ),
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 15),
          child: Text(
            MultiLang().otpOrderHistory(lang).toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              color: themeColor,
              fontWeight: FontWeight.bold
            )
          ),
        ),
        Column(
          children: listOrder,
        )
      ], 'otpHistory', userInfo, lang, money);
    }
    else {
      return loadingScreen();
    }
  }

  void getData() {
    if(loadedInfo && !loadedOrder) {
      GetAPI('https://2ndline.io/mapiv1/historyorder', context, 'POST', {
        'token': userInfo['token'],
        'lang': lang,
      }).then((Map<String, dynamic> json) => ({
        jsonOrder = json,
        listOrder = List<Widget>.generate(json['Data'].length, (index) => 
          itemDisplay2(
            json['Data'][index]['ServiceName'], json['Data'][index]['Phone'] == null ? '' : json['Data'][index]['Phone'], 
            json['Data'][index]['Id'].toString() + '\r\n' + json['Data'][index]['Date'], 
            MultiLang().price(lang) + ': ' + json['Data'][index]['Price'].toString() + '\$', () async {
              var prefs = await SharedPreferences.getInstance();
              prefs.setString('selectedOrderID', json['Data'][index]['Id'].toString());
              prefs.setString('nameService', json['Data'][index]['ServiceName']);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => OtpLoadScreen())));
            },
            Icons.view_list,
            -2, json['Data'][index]['VoiceOtp'], json['Data'][index]['code'].toString()),
            ),
        setState(() {
          loadedOrder = true;
        })
      }));
    }
  }
  void Delay() {
    Future.delayed(Duration(seconds: 8), () {
      if(jsonOrder!['Data'].length > 0) {
        jsonOrder!['Data'].forEach((value) {
        if(value['StatusCode'] == 0) {
          GetAPI('https://2ndline.io/mapiv1/ordercheck', context, 'POST', {
            'token': userInfo['token'],
            'id': value['Id'].toString(),
            'lang': lang,
          }).then((Map<String, dynamic> json) => ({
            
          }));
        }
      });
      }
      setState(() {
        loadedOrder = false;
      });
    });
  }
}