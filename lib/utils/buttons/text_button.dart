// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/images/round_image.dart';

Widget defaultTextButton(String text, Function()? function) {
  return TextButton(
    onPressed: function, 
    child: Text(
      text,
      style: TextStyle(
        color: componentPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      )
    )
  );
}
Widget bottomMenuItem(String text, IconData icon, Function()? function, bool active) {
  return TextButton(
    onPressed: function, 
    child: Column(
      children: [
        Icon(
          icon,
          size: 30,
          color: active ? themeColor : Color.fromRGBO(169, 169, 169, 1)
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: active ? themeColor : Color.fromRGBO(169, 169, 169, 1)
          )
        )
      ],
    ),
  );
}

Widget roundTextButtonIconWithBottomLabel(String linkImage, String label) {
  return TextButton(
    onPressed: () {}, 
    child: Column(
      children: [
        roundImageFromAssset(linkImage, 50, 50),
        Text(
          label,
          style: TextStyle(color: themeColor)
        )
      ]
    ),
  );
}

Widget contentHeader(String header) {
  return Container(
    margin: EdgeInsets.only(top: 15, bottom: 15),
    child: Text(
      header,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 26,
        color: themeColor
      )
    ),
  );
}