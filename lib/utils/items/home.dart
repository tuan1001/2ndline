// ignore_for_file: prefer_const_constructors

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rcore/controller/OtpController.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/images/border_corner_image.dart';

Widget homeListItemWithAssetImage(String imageLink, String subHeader, String header, String price, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                borderCornerImageFromAsset(imageLink, context, 80, 80),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subHeader
                            ),
                            Text(
                              header,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        price,
                        style: TextStyle(
                          color: themeColor,
                        )
                      ),
                    )
                  ],
                )
              ],
            )
            
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: (){}, 
              child: Icon(
                Icons.edit,
                size: 30,
                color: themeColor
              )
            )
          ],
        )
        
      ]
    ),
  );
}
Widget homeListItemWithNetworkImage(String imageLink, String subHeader, String header, String price, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                borderCornerImageFromNetwork(imageLink, context, 80, 80),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subHeader
                            ),
                            Text(
                              header,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        price,
                        style: TextStyle(
                          color: themeColor,
                        )
                      ),
                    )
                  ],
                )
              ],
            )
            
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: (){}, 
              child: Icon(
                Icons.edit,
                size: 30,
                color: themeColor
              )
            )
          ],
        )
        
      ]
    ),
  );
}

Widget horizontalTypeItem(String label, Function()? function, bool active) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: themeColor),
      borderRadius: BorderRadius.all(Radius.circular(100)),
      color: active ? themeColor : Colors.transparent
    ),
    margin: EdgeInsets.only(left: 10, right: 10),
    child: TextButton(
      onPressed: function,
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.white : themeColor,
        )
      ),
    )
  );
}

Widget drawerItem(String title, IconData icon, bool active, Function()? function) {
  return ListTile(
    leading: Icon(icon, color: active ? themeColor : Colors.black),
    title: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        color: active ? themeColor : Colors.black
      )
    ),
    onTap: function,
  );
}

Widget itemDisplay(String title, String subTitle, String des, Function()? function, IconData trailingIcon, int status) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: themeColor),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: getOrderStatusColor(status)
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  des,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: function, 
                  child: Icon(
                    trailingIcon,
                    color: themeColor
                  )
                ),
              ],
            )
          ]
        ),
      ],
    )
  );
}
Widget itemDisplayHoldingPhone(String title, String subTitle, String des, Function()? function, IconData trailingIcon, int status) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: themeColor),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: getOrderStatusColor(status)
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  des,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: function, 
                  child: Icon(
                    trailingIcon,
                    color: themeColor
                  )
                ),
              ],
            )
          ]
        ),
      ],
    )
  );
}
Widget itemDisplay2(String title, String title2, String subTitle, String des, Function()? function, IconData trailingIcon, int status, String? otp, String code) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: themeColor),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$title - $title2',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: getOrderStatusColor(status)
                      ),
                      textAlign: TextAlign.left,
                    ),
                    title2.length < 1 ? Container() : SizedBox(
                      height: 30,
                      child: TextButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: title2));
                        }, 
                        child: Icon(Icons.copy)
                      )
                    )
                  ],
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  des,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: function, 
                  child: Icon(
                    trailingIcon,
                    color: themeColor
                  )
                ),
                
              ],
            )
          ]
        ),
        Row(
          children: [
            otp == null ? Text(
              'Code: $code',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              )
            ) : Text(''),
            otp == null ? SizedBox(
              height: 30,
              child: code.length < 1 ? Container() : TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                }, 
                child: Icon(Icons.copy)
              )
            ) : TextButton(
              onPressed:  () async {
                final assetsAudioPlayer = AssetsAudioPlayer();
                try {
                    await assetsAudioPlayer.open(
                        Audio.network(otp),
                    );
                } catch (t) {
                }
              }, 
              child: Icon(
                Icons.volume_up,
                color: themeColor
              )
            ),
          ],
        )
      ],
    )
  );
}
Icon getIcon(int status) {
  switch(status) {
    case 1:
      return Icon(Icons.check, color: Colors.green);
    case -1:
      return Icon(Icons.cancel, color: Colors.red);
    default:
      return Icon(Icons.timelapse, color: Colors.orange);
  }
}
Widget itemDisplayPrefixIcon(Icon prefixIcon, String title, String subTitle, String des, Function()? function, IconData trailingIcon, int status) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: themeColor),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: prefixIcon,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: getOrderStatusColor(status)
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      des,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: function, 
              child: Icon(
                trailingIcon,
                color: themeColor
              )
            )
          ],
        )
      ]
    ),
  );
}