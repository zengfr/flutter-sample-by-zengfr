// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myweb/framework/app/appScreen.dart';
import 'package:myweb/framework/ext/translations.dart';
import 'package:myweb/framework/util/fSpHelper.dart';
import 'themes.dart';
import 'scales.dart';

class AppOptions {
  AppOptions({
    this.locale,
    this.colorTheme,
    this.bottomNavBarType = BottomNavigationBarType.shifting,
    this.theme,
    this.textScaleFactor,
    this.platform,
    this.textDirection = TextDirection.ltr,
    this.timeDilation = 1.0,
    this.showOffscreenLayersCheckerboard = false,
    this.showRasterCacheImagesCheckerboard = false,
    this.showPerformanceOverlay = false,
  });
  final Locale locale;
  final String colorTheme;
  final BottomNavigationBarType bottomNavBarType;
  final AppTheme theme;
  final AppTextScaleValue textScaleFactor;
  final TextDirection textDirection;
  final double timeDilation;
  final TargetPlatform platform;
  final bool showPerformanceOverlay;
  final bool showRasterCacheImagesCheckerboard;
  final bool showOffscreenLayersCheckerboard;

  AppOptions copyWith({
    Locale locale,
    BottomNavigationBarType bottomNavBarType,
    AppTheme theme,String colorTheme,
    AppTextScaleValue textScaleFactor,
    TextDirection textDirection,
    double timeDilation,
    TargetPlatform platform,
    bool showPerformanceOverlay,
    bool showRasterCacheImagesCheckerboard,
    bool showOffscreenLayersCheckerboard,
  }) {
    return AppOptions(
      locale: locale ?? this.locale,
      bottomNavBarType: bottomNavBarType ?? this.bottomNavBarType,
      theme: theme ?? this.theme,
      colorTheme:colorTheme??this. colorTheme,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      textDirection: textDirection ?? this.textDirection,
      timeDilation: timeDilation ?? this.timeDilation,
      platform: platform ?? this.platform,
      showPerformanceOverlay:
          showPerformanceOverlay ?? this.showPerformanceOverlay,
      showOffscreenLayersCheckerboard: showOffscreenLayersCheckerboard ??
          this.showOffscreenLayersCheckerboard,
      showRasterCacheImagesCheckerboard: showRasterCacheImagesCheckerboard ??
          this.showRasterCacheImagesCheckerboard,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final AppOptions typedOther = other;
    return locale == typedOther.locale &&
        bottomNavBarType == typedOther.bottomNavBarType &&
        theme == typedOther.theme &&
        colorTheme == typedOther.colorTheme &&
        textScaleFactor == typedOther.textScaleFactor &&
        textDirection == typedOther.textDirection &&
        platform == typedOther.platform &&
        showPerformanceOverlay == typedOther.showPerformanceOverlay &&
        showRasterCacheImagesCheckerboard ==
            typedOther.showRasterCacheImagesCheckerboard &&
        showOffscreenLayersCheckerboard ==
            typedOther.showRasterCacheImagesCheckerboard;
  }

  @override
  int get hashCode => hashValues(
        locale,
        bottomNavBarType,
        theme,colorTheme,
        textScaleFactor,
        textDirection,
        timeDilation,
        platform,
        showPerformanceOverlay,
        showRasterCacheImagesCheckerboard,
        showOffscreenLayersCheckerboard,
      );

  @override
  String toString() {
    return '$runtimeType($theme)';
  }
}

const double _kItemHeight = 48.0;
const EdgeInsetsDirectional _kItemPadding =
    EdgeInsetsDirectional.only(start: 56.0, end: 5.0);

class _OptionsItem extends StatelessWidget {
  const _OptionsItem({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double textScaleFactor = MediaQuery.textScaleFactorOf(context);

    return MergeSemantics(
      child: Container(
        constraints: BoxConstraints(minHeight: _kItemHeight * textScaleFactor),
        padding: _kItemPadding,
        alignment: AlignmentDirectional.centerStart,
        child: DefaultTextStyle(
          style: DefaultTextStyle.of(context).style,
          maxLines: 2,
          overflow: TextOverflow.fade,
          child: IconTheme(
            data: Theme.of(context).primaryIconTheme,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _BooleanItem extends StatelessWidget {
  const _BooleanItem(this.title, this.value, this.onChanged, {this.switchKey});

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  // [switchKey] is used for accessing the switch from driver tests.
  final Key switchKey;

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(child: Text(title)),
          Switch(
            key: switchKey,
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem(this.text, this.onTap);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: _FlatButton(
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}

class _FlatButton extends StatelessWidget {
  const _FlatButton({Key key, this.onPressed, this.child}) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: DefaultTextStyle(
        style: Theme.of(context).primaryTextTheme.subtitle1,
        child: child,
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return _OptionsItem(
      child: DefaultTextStyle(
        style: theme.textTheme.bodyText1.copyWith(
          color: theme.accentColor,
        ),
        child: Semantics(
          child: Text(text),
          header: true,
        ),
      ),
    );
  }
}

class _ThemeItem extends StatelessWidget {
  _ThemeItem(this.options, this.onOptionsChanged);

  AppOptions options;
  final ValueChanged<AppOptions> onOptionsChanged;

  @override
  Widget build(BuildContext context) {
    return _BooleanItem(
      Translations.of(context).text("dark_theme"),
      options.theme == kDarkAppTheme,
      (bool value) {
        var opts = options.copyWith(
          theme: value ? kDarkAppTheme : kLightAppTheme,
        );
        onOptionsChanged(
          opts,
        );
        BlocProvider.of<AppOptionsCubit>(context).publish(opts);
      },
      switchKey: const Key('dark_theme'),
    );
  }
}

class _TextScaleFactorItem extends StatelessWidget {
  _TextScaleFactorItem(this.options, this.onOptionsChanged);

  AppOptions options;
  final ValueChanged<AppOptions> onOptionsChanged;

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(Translations.of(context).text("text_size")),
                Text(
                  '${options.textScaleFactor.label}',
                ),
              ],
            ),
          ),
          PopupMenuButton<AppTextScaleValue>(
            itemBuilder: (BuildContext context) {
              return kAllAppTextScaleValues
                  .map<PopupMenuItem<AppTextScaleValue>>(
                      (AppTextScaleValue scaleValue) {
                return PopupMenuItem<AppTextScaleValue>(
                  value: scaleValue,
                  child: Text(scaleValue.label),
                );
              }).toList();
            },
            onSelected: (AppTextScaleValue scaleValue) {
              var opts = options.copyWith(textScaleFactor: scaleValue);
              onOptionsChanged(
                opts,
              );
              BlocProvider.of<AppOptionsCubit>(context).publish(opts);
            },
          ),
        ],
      ),
    );
  }
}

class _TextDirectionItem extends StatelessWidget {
  _TextDirectionItem(this.options, this.onOptionsChanged);

  AppOptions options;
  final ValueChanged<AppOptions> onOptionsChanged;

  @override
  Widget build(BuildContext context) {
    return _BooleanItem(
      'Force RTL',
      options.textDirection == TextDirection.rtl,
      (bool value) {
        var opts = options.copyWith(
          textDirection: value ? TextDirection.rtl : TextDirection.ltr,
        );
        onOptionsChanged(
          opts,
        );
        BlocProvider.of<AppOptionsCubit>(context).publish(opts);
      },
      switchKey: const Key('text_direction'),
    );
  }
}

class _TimeDilationItem extends StatelessWidget {
  _TimeDilationItem(this.options, this.onOptionsChanged);

  AppOptions options;
  final ValueChanged<AppOptions> onOptionsChanged;

  @override
  Widget build(BuildContext context) {
    return _BooleanItem(
      'Slow Motion',
      options.timeDilation != 1.0,
      (bool value) {
        var opts = options.copyWith(
          timeDilation: value ? 10.0 : 1.0,
        );   
        BlocProvider.of<AppOptionsCubit>(context).publish(opts);
        onOptionsChanged(
          opts,
        );
      },
      switchKey: const Key('slow_motion'),
    );
  }
}

class _PlatformItem extends StatelessWidget {
  _PlatformItem(this.options, this.onOptionsChanged);

  AppOptions options;
  final ValueChanged<AppOptions> onOptionsChanged;

  String _platformLabel(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.fuchsia:
        return 'fuchsia';
      case TargetPlatform.iOS:
        return 'iOS';
      case TargetPlatform.windows:
        return 'windows';
      case TargetPlatform.macOS:
        return 'macOS';
      case TargetPlatform.linux:
        return 'linux';
    }
    assert(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Platform Mechanics'),
                Text(
                  '${_platformLabel(options.platform)}',
                ),
              ],
            ),
          ),
          PopupMenuButton<TargetPlatform>(
            itemBuilder: (BuildContext context) {
              return TargetPlatform.values.map((TargetPlatform platform) {
                return PopupMenuItem<TargetPlatform>(
                  value: platform,
                  child: Text(_platformLabel(platform)),
                );
              }).toList();
            },
            onSelected: (TargetPlatform platform) {
              var opts = options.copyWith(platform: platform);
              onOptionsChanged(
                opts,
              );
              BlocProvider.of<AppOptionsCubit>(context).publish(opts);
            },
          ),
        ],
      ),
    );
  }
}

class AppOptionsPage extends StatelessWidget {
  const AppOptionsPage({
    Key key,
    this.onOptionsChanged,
  }) : super(key: key);

  final ValueChanged<AppOptions> onOptionsChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppOptionsCubit, AppOptions>(builder: _build);
  }

  Widget _build(BuildContext context, AppOptions options) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(Translations.of(context).text("setting")),
      ),
      body: ListView(
        children: <Widget>[
          _Heading(Translations.of(context).text("display")),
          _buildLocaleSetting(context, options),
          _buildNavTypeSetting(context, options),
          _buildColorSetting(context, options),
          _ThemeItem(options, onOptionsChanged),
          _TextScaleFactorItem(options, onOptionsChanged),

          const Divider(),
          const _Heading('Platform Mechanics'),
          _PlatformItem(options, onOptionsChanged),
          _TextDirectionItem(options, onOptionsChanged),
          _TimeDilationItem(options, onOptionsChanged),
        ]..addAll(
            _enabledDiagnosticItems(context, options),
          ),
      ),
    );
  }

  Widget _buildColorSetting(BuildContext context, AppOptions options) {
    return ExpansionTile(
      title: Text(Translations.of(context).text("color")),
      leading: Icon(
        Icons.color_lens,
        color: Theme.of(context).accentColor,
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: themeColorMap.keys.map((key) {
            
              Color color = themeColorMap[key];
              return Material(
                  color: color,
                  child: InkWell(
                    onTap: () {
                      FSpHelper.putString("colorkey", key);
                    
                      var opts = options.copyWith(
                        colorTheme: key,
                      );
                      onOptionsChanged(
                        opts,
                      );
                      BlocProvider.of<AppOptionsCubit>(context)
                          .publish(opts);
                    },
                    child: Container(
                        width: 40,
                        height: 40,
                        child: key == options.colorTheme
                            ? Icon(Icons.check)
                            : Center()),
                  ));
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildLocaleSetting(BuildContext context, AppOptions options) {
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(Translations.of(context).text("locale")),
                Text('${options.locale}'),
              ],
            ),
          ),
          PopupMenuButton<Locale>(
            itemBuilder: (BuildContext context) {
              return appTranslations.supportedLocales().map((Locale locale) {
                return PopupMenuItem<Locale>(
                  value: locale,
                  child: Text(locale.countryCode),
                );
              }).toList();
            },
            onSelected: (Locale locale) {
              var opts = options.copyWith(locale: locale);
              onOptionsChanged(
                opts,
              );
              BlocProvider.of<AppOptionsCubit>(context).publish(opts);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavTypeSetting(BuildContext context, AppOptions options) {
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(Translations.of(context).text("nav_type")),
                Text('${options.bottomNavBarType.toString().split('.').last}'),
              ],
            ),
          ),
          PopupMenuButton<BottomNavigationBarType>(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<BottomNavigationBarType>(
                  value: BottomNavigationBarType.fixed,
                  child: Text('fixed'),
                ),
                PopupMenuItem<BottomNavigationBarType>(
                  value: BottomNavigationBarType.shifting,
                  child: Text('shifting'),
                ),
              ];
            },
            onSelected: (BottomNavigationBarType type) {
              var opts = options.copyWith(bottomNavBarType: type);
              onOptionsChanged(
                opts,
              );
              BlocProvider.of<AppOptionsCubit>(context).publish(opts);
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _enabledDiagnosticItems(
      BuildContext context, AppOptions options) {
    if (null == options.showOffscreenLayersCheckerboard ??
        options.showRasterCacheImagesCheckerboard ??
        options.showPerformanceOverlay) return const <Widget>[];

    final List<Widget> items = <Widget>[
      const Divider(),
      const _Heading('Diagnostics'),
    ];

    if (options.showOffscreenLayersCheckerboard != null) {
      items.add(
        _BooleanItem(
          'Highlight offscreen layers',
          options.showOffscreenLayersCheckerboard,
          (bool value) {
            var opts = options.copyWith(showOffscreenLayersCheckerboard: value);
            onOptionsChanged(opts);
            BlocProvider.of<AppOptionsCubit>(context).publish(opts);
          },
          switchKey: const Key('highlight_offscreen_layers'),
        ),
      );
    }
    if (options.showRasterCacheImagesCheckerboard != null) {
      items.add(
        _BooleanItem(
          'Highlight raster cache images',
          options.showRasterCacheImagesCheckerboard,
          (bool value) {
            var opts =
                options.copyWith(showRasterCacheImagesCheckerboard: value);
            onOptionsChanged(opts);
            BlocProvider.of<AppOptionsCubit>(context).publish(opts);
          },
          switchKey: const Key('highlight_raster_cache_images'),
        ),
      );
    }
    if (options.showPerformanceOverlay != null) {
      items.add(
        _BooleanItem(
          'Show performance overlay',
          options.showPerformanceOverlay,
          (bool value) {
            var opts = options.copyWith(showPerformanceOverlay: value);
            onOptionsChanged(opts);
            BlocProvider.of<AppOptionsCubit>(context).publish(opts);
          },
          switchKey: const Key('show_performance_overlay'),
        ),
      );
    }

    return items;
  }
}
