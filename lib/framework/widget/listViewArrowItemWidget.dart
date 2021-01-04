import 'package:flutter/material.dart';
import 'dart:ui';

//https://github.com/Natoto/flutterWechat/blob/master/lib/FindView.dart
class ListViewArrowItemWidget {
  static Container buildListViewArrowItem(String iconName, String contentName,
      Color color, double topY, double lineH) {
    return new Container(
      padding: EdgeInsets.only(top: topY),
      color: Color.fromARGB(0xff, 0xf2, 0xf2, 0xf2),
      // height: 54.0 + topY + lineH ,
      child: new Column(
        children: <Widget>[
          Container(
              height: 54.0 + lineH,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _leftrow(iconName, contentName),
                  Container(
                    width: 80,
                    height: 100,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                          "wechatassts/arrowOnclick_ico@2x.png", //arrow_icon
                          width: 20.0,
                          height: 20.0,
                        ),
                        Container(
                          width: 5.0,
                        )
                      ],
                    ),
                  ),
                ],
              )),
          Container(
            height: lineH,
            child: new Row(
              children: <Widget>[
                Container(
                  width: 60,
                  color: Colors.white,
                ),
                Container(
                  color: Color.fromARGB(0x7d, 0xd9, 0xd9, 0xd9),
                  width: window.physicalSize.width / 3 - 60,
                )
              ],
            ),
            // padding: EdgeInsets.all(100),
          ),
        ],
      ),
    );
  }

  static Row _leftrow(String iconName, String contentName) {
    return new Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(width: 17),
          new Image.asset(
            iconName,
            height: 22.0,
            width: 22,
            // color: color,
          ),
          Container(width: 17),
          new Text(
            contentName,
            style: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
            ),
          )
        ]);
  }
}
