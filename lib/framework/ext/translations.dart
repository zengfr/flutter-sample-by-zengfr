import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Translations {
// 缓存已创建的对象
  static final Map<Locale, Translations> _cache = <Locale, Translations>{};
  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }
  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
     _reloadValues(locale);
    return translations;
  }

  factory Translations(Locale locale) {
    return _cache.putIfAbsent(locale, () => Translations._internal(locale));
  }
  Translations._internal(Locale locale) {
    this.locale = locale;
   
  }

  Locale locale;
 static Map<dynamic, dynamic> _localizedValues={};

  String text(String key) {
    try {
      String value = _localizedValues[key];
      if (value == null || value.isEmpty) {
        return englishText(key);
      } else {
        return value;
      }
    } catch (e) {
      return englishText(key);
    }
  }

  String englishText(String key) {
    if (_localizedValues = null) {
      return '** $key not found';
    }
    return _localizedValues[key] ?? '** $key not found';
  }

 static void _reloadValues(Locale locale) async {
    String jsonContent = await rootBundle
        .loadString("lib/locale/i18n_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
  }

  get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      appTranslations.supportedLanguages.containsKey(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}

class SpecificLocalizationDelegate extends LocalizationsDelegate<Translations> {
  final Locale overriddenLocale;

  const SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<Translations> load(Locale locale) =>
      Translations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => true;
}

typedef void LocaleChangeCallback(Locale locale);

////
///// 改变语言时的应用刷新核心方法：
/// onLocaleChange(Locale locale){
///    setState((){
///     _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
///    });
///  }
/// applic.onLocaleChanged = onLocaleChange;
/// title:Text(Translations.of(context).text("home"))
///切换语言的方法：调用applic.onLocaleChanged(new Locale('en',''));
/////////
class APPTranslations {
  // List of supported languages
  final Map<String, String> supportedLanguages = {
    'zh': 'CN',
    'en': 'US',
  };
  // Returns the list of supported Locales
  List<Locale> supportedLocales() => supportedLanguages.entries
      .map<Locale>((e) => new Locale(e.key, e.value))
      .toList();
  // Function to be invoked when changing the working language
  LocaleChangeCallback onLocaleChanged;

  ///
  /// Internals
  ///
  static final APPTranslations _appTranslations =
      new APPTranslations._internal();
  factory APPTranslations() {
    return _appTranslations;
  }
  // 私有的构造函数
  APPTranslations._internal();
}

APPTranslations appTranslations = new APPTranslations();
