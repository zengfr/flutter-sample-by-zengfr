import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:myweb/framework/app/appView.dart';

class AppWebVideo extends AppView {
   AppWebVideo({Key key, this.src, this.width, this.height, this.startAt})
      : super(key: key);

  final int width;
  final int height;
  final String src;
  final double startAt;
  @override
  void _init(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory(this.key?.toString(),
        (int viewId) {
      final video = VideoElement()
        ..width = this.width
        ..height = this.height
        ..src = this.src + '#t=${this.startAt}'
        ..autoplay = true
        ..controls = true
        ..style.border = 'none';
      return video;
    });
  }

  @override
  Widget _build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: HtmlElementView(viewType: this.key?.toString()),
    );
  }
}
