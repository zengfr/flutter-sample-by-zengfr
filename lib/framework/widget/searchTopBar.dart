import 'package:flutter/material.dart';
import '../util/fstyle.dart';

class SearchTopBar extends StatelessWidget {
  final ValueChanged<String> seachTxtChanged;
  final TextEditingController controller;
  SearchTopBar({Key key, this.seachTxtChanged, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: FStyle.fConstant.searchTxtFieldHeight,
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: FStyle.fColor.divideLineColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            color: FStyle.fColor.floorTitleColor,
            size: 20,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (s) {
                print(s);
              }, // 键盘回车键
              onChanged: seachTxtChanged,
              cursorWidth: 1.5,
              autofocus: true,
              cursorColor: FStyle.fColor.floorTitleColor,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  hintText: FStyle.fString.homeSearchBarHint,
                  hintStyle: TextStyle(fontSize: 14),
                  border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}
