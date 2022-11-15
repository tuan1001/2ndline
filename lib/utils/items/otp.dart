

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget itemCountrySelect(String link, String label, Function()? function) {
  return TextButton(
    onPressed: function,
    child: Row(
      children: [
        Image.network(
          link,
          height: 30,
        ),
        Text(
          ' ' + label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black
          )
        )
      ]
    ),
  );
}
Widget itemSelect(String label, Function()? function) {
  return TextButton(
    onPressed: function,
    child: Row(
      children: [
        Text(
          ' ' + label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black
          )
        )
      ]
    ),
  );
}