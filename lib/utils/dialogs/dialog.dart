// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/text_input/text_input.dart';

void notiDialog(String title, String content, Function()? function, BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (context) => Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 200,
        decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )
            ),
            Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              )
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: function, 
                child: Text('Close', style: TextStyle(color: themeColor))
              ),
            )
            
          ],
        )
      )
    )
  );
}
void yesNoDialog(String title, String content, Function()? functionYes, Function()? functionNo, BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (context) => Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 200,
        decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )
            ),
            Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: functionYes, 
                  child: Text('Yes', 
                    style: TextStyle(
                      color: themeColor
                    )
                  )
                ),
                TextButton(
                  onPressed: functionNo, 
                  child: Text('No', 
                    style: TextStyle(
                      color: themeColor
                    )
                  )
                ),
              ]
            )
          ],
        )
      )
    )
  );
}