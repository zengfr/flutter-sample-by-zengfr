import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:myweb/framework/app/appView.dart';

class AppWebView extends AppView {
  AppWebView({Key key, this.src, this.width, this.height}) : super(key: key);

  final int width;
  final int height;
  String src;
  @override
  void _init(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory(
        this.key?.toString(),
        (int viewId) => IFrameElement()
          ..allowFullscreen = true
          ..allow = ''
          ..src = this.src
          ..style.border = 'none'
          ..width = '100%'
          ..height = '100%');
  }

  @override
  Widget _build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: HtmlElementView(viewType: this.key?.toString()),
    );
  }
}
