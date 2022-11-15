// ignore_for_file: avoid_init_to_null, prefer_collection_literals, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rcore/controller/OtpController.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/items/otp.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/utils/text_input/selection.dart';
import 'package:rcore/views/layouts/layout2.dart';
import 'package:rcore/views/layouts/loading.dart';
import 'package:rcore/views/numbers/number_holding_screen.dart';
import 'package:rcore/views/otp/otp_create_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpLoadScreen extends StatefulWidget {
  const OtpLoadScreen({Key? key}) : super(key: key);

  @override
  State<OtpLoadScreen> createState() => _OtpLoadScreen();
}

class _OtpLoadScreen extends State<OtpLoadScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> userInfo = new Map();
  bool loadedInfo = false;
  String lang = '';
  bool loadedLang = false;
  String money = '0 \$';
  bool loadedMoney = false;
  bool loadedData = false;
  String? nameService = null;

  List<Widget> holdTimeList = List<Widget>.generate(0, (index) => Container());
  bool loadedHoldTime = false;

  Map<String, dynamic>? data = null;
  Map<String, dynamic>? selectedHoldingTime = null;

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
    getHoldTime();
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
      return layout2(_scaffoldKey, context, nameService.toString() + ' ' + MultiLang().createOtp(lang), [
        Text(
          MultiLang().yourPhoneNumber(lang),
          style: TextStyle(
            fontSize: 26,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data != null && data!['phone'] != null ? data!['phone'] + ' ' : "",
              style: TextStyle(
                fontSize: 26,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: data != null && data!['phone'] != null ? data!['phone'] : ""));
              }, 
              child: Icon(Icons.copy)
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Text(
            data != null ? data!['message'] : "",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MultiLang().orderStatus(lang),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey
                    )
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: data != null ? getOrderStatusColor(data!['statusOrder']) : Colors.orange
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    MultiLang().expireDaate(lang),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey
                    )
                  ),
                  Text(
                    data != null ? data!['Exprire'] : "",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    )
                  ),
                ],
              ),
            ]
          ),
        ),
        data != null && data!['haveVoice'].toString() != 'true' ? Column(
          children: [
            Text(
              'OTP',
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              data != null ? data!['code'] : "",
              style: TextStyle(
                fontSize: 26,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ]
        ) : Container(),
        Row(
          children: [
            Text(
              MultiLang().voiceOTP(lang) + ': ',
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.bold,
              )
            ),
            data == null ? Text(
              MultiLang().loading(lang),
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              )
            ) : (data!['haveVoice'].toString() == 'false' ? Text(
              MultiLang().unavailable(lang),
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              )
            ) : TextButton(
              onPressed: () async {
                final assetsAudioPlayer = AssetsAudioPlayer();
                try {
                    await assetsAudioPlayer.open(
                        Audio.network(data!['audioUrl']),
                    );
                } catch (t) {
                    notiDialog(MultiLang().notification(lang), 'Cannot open audio', () {
                      Navigator.pop(context);
                    }, context);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.headphones),
                  Text(MultiLang().touchToList(lang))
                ]
              ),
            )),
          ],
        ),
        data != null && data!['statusOrder'] == 1 && DateTime.parse(convertDate(data!['Exprire'])).difference(DateTime.now()).inMinutes > -15 ?
        dialogSelection(holdTimeList, selectedHoldingTime == null ? MultiLang().chooseHoldTime(lang) : selectedHoldingTime!['time'].toString() + ' ' + selectedHoldingTime!['timeUnit'].toString(), context) : Container(),
        data != null && data!['statusOrder'] == 1 && DateTime.parse(convertDate(data!['Exprire'])).difference(DateTime.now()).inMinutes > -15 ?
        primarySizedButton(data == null || data!['statusOrder'] != 1 ? MultiLang().pleaseWaitOTP(lang) : MultiLang().holdThisNumber(lang), context, data != null && data!['statusOrder'] == 1 ? () {
          if(selectedHoldingTime == null) {
            notiDialog(MultiLang().notification(lang), MultiLang().pleaseChooseHoldTime(lang), () {
              Navigator.pop(context);
            }, context);
            return;
          }
          GetAPI('https://2ndline.io/mapiv1/KeepSim', context, 'POST', {
            'token': userInfo['token'],
            'orderId': data!['id'].toString(),
            'time': selectedHoldingTime!['time'].toString(),
            'unit': selectedHoldingTime!['timeUnit'],
            'lang': lang
          }).then((Map<String, dynamic> json) => ({
            if(json['status'] == 1) {
              notiDialog(MultiLang().notification(lang), json['message'], () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => NumberHoldingScreen())));
              }, context)
            }
            else {
              notiDialog(MultiLang().notification(lang), json['message'], () {
                Navigator.pop(context);
              }, context)
            }
          }));
        } : () {}) : Container(),
        // data != null && DateTime.parse(convertDate(data!['Exprire'])).difference(DateTime.now()).inMinutes > -15 ?
        // Container(
        //   margin: EdgeInsets.only(top: 15),
        //   child: primarySizedButton(MultiLang().cancel(lang), context, () {
        //     Navigator.pop(context);
        //   }),
        // ):Container(),
        data != null && data!['statusOrder'] == 1 && DateTime.parse(convertDate(data!['Exprire'])).difference(DateTime.now()).inMinutes > -10 ?
        Container(
          margin: EdgeInsets.only(top: 15) ,
          child: primarySizedButton('Continue', context, () {
          GetAPI('https://2ndline.io/mapiv1/ContinueOrder', context, 'POST', {
            'token': userInfo['token'],
            'orderId': data!['id'].toString(),
          }).then((Map<String, dynamic> json) => ({
            if(json['status'].toString() != '1') {
              notiDialog('', json['message'], () {
                Navigator.pop(context);
              }, context)
            }
            else {
              notiDialog('', json['message'], () async {
                var prefs = await SharedPreferences.getInstance();
                prefs.setString('selectedOrderID', json['id'].toString());
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => OtpLoadScreen())));
              }, context)
            }
          }));
        }),
        ) : Container()
      ], '', userInfo, lang, money);
    }
    else {
      return loadingScreen();
    }
    }

  void getData() async {
    if(loadedInfo && !loadedData) {
      var prefs = await SharedPreferences.getInstance();
      String? selectedOrderID = await prefs.getString('selectedOrderID');
      nameService = await prefs.getString('nameService');
      Future.delayed(Duration(seconds: 3), () {
        GetAPI('https://2ndline.io/mapiv1/ordercheck', context, 'POST', {
          'token': userInfo['token'],
          'id': selectedOrderID != null ? selectedOrderID : "",
          'lang': lang,
        }).then((Map<String, dynamic> json) => ({
          data = json['data'],
          if(json['data']['statusOrder'].toString() != '0') {
            loadedData = true
          },
          setState(() {})
        }));
      });
    }
  }
  String convertDate(String value) {
    var strs = value.split(' ');
    var dates = strs[0].split('/');
    return dates[2] + '-' +dates[1] + '-' + dates[0] + ' ' + strs[1];
  }

  void getHoldTime() {
    if(loadedData == true && !loadedHoldTime) {
      GetAPI('https://2ndline.io/mapiv1/AvailableTime', context, 'GET', {}).then((Map<String, dynamic> json) => ({
        holdTimeList = List<Widget>.generate(json.length, 
          (index) => itemSelect(json[index.toString()]['time'].toString() + ' ' + json[index.toString()]['timeUnit'].toString(), () {
            setState(() {
              selectedHoldingTime = json[index.toString()];
            });
            Navigator.pop(context);
          })),
        setState(() {
          loadedHoldTime = true;
        })
      }));
    }
  }
}