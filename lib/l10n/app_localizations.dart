import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

abstract class AppLocalizations {
  const AppLocalizations();
  String get appTitle;
  String get discoverButton;
  String get homePage;
  String get directory;
  String get english;
  String get arabic;
  String get discoverDxbDirectory;
  String get dubai;
  String get abuDhabi;
  String get sharjah;
  String get burjKhalifa;
  String get burjKhalifaDescription;
  String get dubaiMall;
  String get dubaiMallDescription;
  String get palmJumeirah;
  String get palmJumeirahDescription;
  String get noTitle;
  String get noImageFound;
  String get emptyDescription;
  String get favorite;
  String get selectLanguage;
  String get switchLanguage;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
  ];
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return _loadedTranslations(locale) ??
        (locale.languageCode == 'ar'
            ? AppLocalizationsAr.load(locale)
            : AppLocalizationsEn.load(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ar'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;

  static Future<AppLocalizations>? _loadedTranslations(Locale locale) {
    if (locale.languageCode == 'ar') {
      return SynchronousFuture<AppLocalizations>(const AppLocalizationsAr());
    }
    return SynchronousFuture<AppLocalizations>(const AppLocalizationsEn());
  }
}

class SynchronousFuture<T> implements Future<T> {
  SynchronousFuture(this._value);

  final T _value;

  @override
  Stream<T> asStream() =>
      Stream<T>.fromIterable(<T>[_value]);

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) =>
      Future<T>.value(_value).catchError(onError, test: test);

  @override
  Future<S> then<S>(FutureOr<S> Function(T) onValue,
          {Function? onError}) =>
      Future<T>.value(_value).then<S>(onValue, onError: onError);

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) =>
      Future<T>.value(_value).timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) =>
      Future<T>.value(_value).whenComplete(action);
}
