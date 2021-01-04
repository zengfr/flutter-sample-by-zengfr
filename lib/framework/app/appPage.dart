import 'package:flutter/material.dart';
import 'package:myweb/framework/app/appView.dart';
import 'package:myweb/framework/core/appBundle.dart';

abstract class AppPage extends AppView{
  AppPage.arg({Key key,this.bundle}):super(key: key);
  AppPage({Key key,this.bundle}):super(key: key);
  final AppBundle bundle;
}