// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, prefer_collection_literals, unnecessary_new, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/drawer/drawer.dart';
import 'package:rcore/utils/items/home.dart';
import 'package:rcore/utils/language/multilang.dart';
import 'package:rcore/views/affiliate/affiliate_screen.dart';
import 'package:rcore/views/numbers/number_holding_screen.dart';
import 'package:rcore/views/otp/otp_create_screen.dart';
import 'package:rcore/views/otp/otp_history_screen.dart';
import 'package:rcore/views/profile/change_password.dart';
import 'package:rcore/views/profile/profile_screen.dart';
import 'package:rcore/views/transaction/transaction_create_screen.dart';
import 'package:rcore/views/transaction/transaction_history_screen.dart';
Scaffold layout2(GlobalKey<ScaffoldState> _scaffoldKey, BuildContext context, String title, List<Widget> body, String activeName, Map<String, dynamic> userInfo, String lang, String money) {
  return Scaffold(
    key: _scaffoldKey,
    appBar: AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black
        )
      ),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, // <-- SEE HERE
      ),
      leading: Image.asset('lib/assets/images/logo-only.png'),
      actions: [
        IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          }, 
          icon:  Icon(Icons.list)
        )
      ],
    ),
    drawer: Drawer(
      child: ListView(
        children: [
          drawerHeader(userInfo['fullName'] == null ? "" : userInfo['fullName'], userInfo['phone'] == null ? "" : userInfo['phone'], () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
          }, money),
          
          // drawerItem(MultiLang().createOtp(lang), Icons.add, activeName == 'otpCreate', () {
          //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpCreateScreen()));
          // }),
          drawerItem(MultiLang().topUp(lang), Icons.credit_card_outlined, activeName == 'topUp', () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionCreateScreen()));
          }),
          drawerItem(MultiLang().otpOrderHistory(lang), Icons.format_align_justify, activeName == 'otpHistory', () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpHistoryScreen()));
          }),
          drawerItem(MultiLang().transactionHistory(lang), Icons.attach_money, activeName == 'transactionHistory', () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionHistoryScreen()));
          }),
          // drawerItem(MultiLang().holdingNumber(lang), Icons.phone_android, activeName == 'holdingNumber', () {
          //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => NumberHoldingScreen()));
          // }),
          drawerItem(MultiLang().affiliate(lang), Icons.all_inclusive, activeName == 'affiliate', () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Affiliate()));
          }),
          drawerItem(MultiLang().changePassword(lang), Icons.security, activeName == 'changePassword', () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
          }),
          drawerItem(MultiLang().logout(lang), Icons.logout, activeName == 'logout', () {
            yesNoDialog(MultiLang().notification(lang), MultiLang().doYouWantToExist(lang), () {
              exit(0);
            }, () {
              Navigator.pop(context);
            }, context);
          }),
        ],
      ),
    ),
    body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            //Body
            child: Container(
              height: MediaQuery.of(context).size.height - 82,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(252, 252, 252, 1),
              ),
              child: ListView(
                children: body,
              ),
            ),
          ),
        ]
      )
    )
  ); 
}