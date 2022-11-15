// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, prefer_if_null_operators, prefer_collection_literals, unnecessary_new, avoid_unnecessary_containers, await_only_futures, prefer_is_empty, unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/views/landing/landing_screen.dart';
import 'package:rcore/views/landing/login_screen.dart';
import 'package:rcore/views/otp/otp_create_screen.dart';
import 'package:rcore/views/otp/otp_history_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

import '../main.dart';

Future<Map<String, dynamic>> GetAPI(String link, BuildContext context, String method, Map<String, dynamic> params) async {
  HttpOverrides.global = MyHttpOverrides();
  try {
    // List<String> param = List<String>.generate(0, (index) => "");
    // if(params.length > 0) {
    //   params.forEach((key, value) { 
    //     param.add(key.toString() + "=" + value.toString());
    //   });
    //   link = link + "?" + param.join("&");
    // }
    print("Getting data from: " + link);
    // final http.Request request = http.Request(method, Uri.parse(link));
    // final http.StreamedResponse response = await http.Client().send(request);
    // String responseData =  await response.stream.transform(utf8.decoder).join();
    http.Response response = new http.Response(jsonEncode({}), 401);
    switch(method) {
      case 'POST':
        print(jsonEncode(params).toString());
        response = await http.post(
          Uri.parse(link),
          body: params,
        );
        break;
      case 'GET':
        response = await http.get(
          Uri.parse(link),
        );
        break;
    }
    Map<String, dynamic> jsonData = new Map();
    try {
     jsonData = json.decode(response.body);
    }
    catch(e) {
      print(response.body);
      List<dynamic> list = json.decode(response.body);
      int i = 0;
      for(var item in list) {
        jsonData[i.toString()] = item == null ? "" : item;
        i++;
      }
    }
    print(jsonData);
    if(response.statusCode != 200) {
      notiDialog('Error',jsonData['message'], () {
        Navigator.pop(context);
      }, context);
      return new Map();
    }
    return jsonData;
  }
  catch (e) {
    Clipboard.setData(ClipboardData(text: e.toString()));
    notiDialog('Error',"Cannot connect to server!" + e.toString(), () {
      Navigator.pop(context);
    }, context);
    rethrow;
  }
}

void actionLogin(Map<String, dynamic> param, BuildContext context) async {
  GetAPI('https://2ndline.io/mapiv1/loginm', context, 'POST', param).then((Map<String, dynamic> json) => ({
    if(json['status'].toString() == 'true') {
      notiDialog('', json['message'], () async {
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString('infoUser', jsonEncode(json['data']));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OtpHistoryScreen()));
      }, context)
    }
    else {
      notiDialog('', json['message'], () {
        Navigator.pop(context);
      }, context)
    }
  }));
}

void actionRegister(Map<String, dynamic> param, BuildContext context) {
  GetAPI('https://2ndline.io/mapiv1/registerm', context, 'POST', param).then((Map<String, dynamic> json) => ({
    if(json['status'].toString() == '1') {
      notiDialog('Thông báo', json['message'], () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => LoginScreen())));
      }, context)
    }
    else {
      notiDialog('Thông báo', json['message'], () {
        Navigator.pop(context);
      }, context)
    }
  }));
}

void updateLanguage(String language) async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.setString('language', language);
  print("SAVED:" + language);
}
Future<String> getLanguage() async {
  String? res = "";
  var prefs = await SharedPreferences.getInstance();
  res = await prefs.getString('language');
  print('LOADING: ' + res.toString());
  return res == null || res.toString().length < 1  ? "en" : res.toString();
}

Future<Map<String, dynamic>> getUserInfo() async {
  String? res = "";
  var prefs = await SharedPreferences.getInstance();
  res = await prefs.getString('infoUser');
  return res == null ? new Map() : jsonDecode(res);
}