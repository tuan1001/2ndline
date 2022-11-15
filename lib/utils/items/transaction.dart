// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';

Widget itemTransactionLine(String label, String content, Function()? function) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Text(
            label + ': ',
            style: TextStyle(
              fontSize: 18,
            )
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            )
          ),
        ],
      ),
      TextButton(
        onPressed: function, 
        child: Icon(
          Icons.copy,
          color: themeColor
        ))
    ],
  );
}
Widget contentWithLeadingLabel(String label, String content) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Text(
            label + ': ',
            style: TextStyle(
              fontSize: 18,
            )
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            )
          ),
        ],
      ),
    ],
  );
}