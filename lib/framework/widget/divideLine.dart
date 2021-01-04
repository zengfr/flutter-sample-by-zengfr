import 'package:flutter/material.dart';

import '../util/screenUtil.dart';

class DivideLine extends StatelessWidget {
  final double width;
  final Color color;
  DivideLine({Key key, this.width, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.instance.L(this.width),
      alignment: Alignment.center,
      color: this.color,
    );
  }
}
