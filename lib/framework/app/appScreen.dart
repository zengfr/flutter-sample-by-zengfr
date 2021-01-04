import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myweb/framework/ext/scales.dart';
import 'package:myweb/framework/ext/themes.dart';
import 'package:myweb/framework/ext/translations.dart';
import 'appPage.dart';
import '../ext/options.dart';
import 'appRouters.dart';

abstract class AppScreen extends AppPage {
  String get title;
  Widget get homePage;
  Map<String, PageBuilder> get allRouters;
  AppOptions _options;
  Timer _timeDilationTimer;
  void _handleOptionsChanged(AppOptions newOptions) {
    if (_options.timeDilation != newOptions.timeDilation) {
      _timeDilationTimer?.cancel();
      _timeDilationTimer = null;
      if (newOptions.timeDilation > 1.0) {
        _timeDilationTimer = Timer(const Duration(milliseconds: 150), () {
          timeDilation = newOptions.timeDilation;
        });
      } else {
        timeDilation = newOptions.timeDilation;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppRouters.setupPageRoutes(allRouters);

    AppRouters.setupPageRoute(
        '/options',
        PageBuilder(
            builder: (bundle) => AppOptionsPage(
                  onOptionsChanged: _handleOptionsChanged,
                )));
    return BlocProvider<AppOptionsCubit>(
        create: (BuildContext context) => AppOptionsCubit(),
        child: BlocBuilder<AppOptionsCubit, AppOptions>(builder: _build));
  }

  Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
    var style = Theme.of(context).textTheme.bodyText1;
    return Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "exception:" +error.toString() +error.exception.toString(),
        style: style,
      ),
      Text(
        "summary:" + error.summary.toString(),
        style: style,
      ),Text(
        "info:" + error.informationCollector.toString(),
        style: style,
      ),
      Text(
        "stack:" + error.stack.toString(),
        style: style,
      ),
    ]));
  }

  Widget _build(BuildContext context, AppOptions options) {
    _options = options;
    String colorKey = options.colorTheme;
    Color _themeColor = options.theme.data.primaryColor;
    if (colorKey != null && themeColorMap[colorKey] != null) {
      _themeColor = themeColorMap[colorKey];
    }
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      Zone.current.handleUncaughtError(details.exception, details.stack);
    };
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return getErrorWidget(context, errorDetails);
    };
    return MaterialApp(
      title: this.title,
      theme: options.theme.data.copyWith(
        primaryColor: _themeColor,
        accentColor: _themeColor,
      ),
      darkTheme: options.theme.data.copyWith(
        primaryColor: _themeColor,
        accentColor: _themeColor,
      ),
      showPerformanceOverlay: options.showPerformanceOverlay,
      checkerboardOffscreenLayers: options.showOffscreenLayersCheckerboard,
      checkerboardRasterCacheImages: options.showRasterCacheImagesCheckerboard,
      localizationsDelegates: [
        // 注册一个新的delegate
        SpecificLocalizationDelegate(options.locale),
        // 指向默认的处理翻译逻辑的库
        //const TranslationsDelegate(),
        // 本地化的代理类
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: appTranslations.supportedLocales(),
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: options.textDirection,
          child: _applyTextScaleFactor(child, options),
        );
      },
      home: this.homePage,
    );
  }

  Widget _applyTextScaleFactor(Widget child, AppOptions options) {
    return Builder(
      builder: (BuildContext context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: options.textScaleFactor.scale,
          ),
          child: child,
        );
      },
    );
  }
}

class AppOptionsCubit extends Cubit<AppOptions> {
  AppOptionsCubit()
      : this.arg(AppOptions(
          locale: appTranslations.supportedLocales()[0],
          theme: kLightAppTheme,
          textScaleFactor: kAllAppTextScaleValues[0],
          timeDilation: timeDilation,
          platform: defaultTargetPlatform,
        ));
  AppOptionsCubit.arg(AppOptions s) : super(s);
  void publish([AppOptions options]) {
    if (options == null) options = state;
    this.emit(options);
  }
}
