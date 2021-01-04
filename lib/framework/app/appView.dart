import 'package:flutter/material.dart';

///抽象视图
///
abstract class AppView extends StatelessWidget {
  AppView({ Key key }) : super(key: key);
  bool _isinit = false;
  @override
  Widget build(BuildContext context) {
    if (!_isinit) {
      _init(context);
      _isinit = true;
    }
    _build(context);
  }

  void _init(BuildContext context);
  Widget _build(BuildContext context);
}
