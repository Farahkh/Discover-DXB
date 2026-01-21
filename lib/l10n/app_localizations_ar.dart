import 'package:flutter/material.dart';
import 'app_localizations.dart';

class AppLocalizationsAr extends AppLocalizations {
  const AppLocalizationsAr();
  @override
  String get appTitle => 'اكتشف دبي';

  @override
  String get discoverButton => 'اكتشف';

  @override
  String get homePage => 'الصفحة الرئيسية';

  @override
  String get directory => 'الدليل';

  @override
  String get english => 'English';

  @override
  String get arabic => 'العربية';

  @override
  String get discoverDxbDirectory => 'دليل اكتشف دبي';

  @override
  String get dubai => 'دبي';

  @override
  String get abuDhabi => 'أبو ظبي';

  @override
  String get sharjah => 'الشارقة';

  @override
  String get burjKhalifa => 'برج خليفة';

  @override
  String get burjKhalifaDescription => 'أطول مبنى في العالم يقع في دبي.';

  @override
  String get dubaiMall => 'مول دبي';

  @override
  String get dubaiMallDescription => 'أحد أكبر مراكز التسوق في العالم.';

  @override
  String get palmJumeirah => 'نخلة جميرا';

  @override
  String get palmJumeirahDescription => 'نخلة في البحر، معروفة بفنادقها ومساكنها الفاخرة.';

  @override
  String get noTitle => 'لا يوجد عنوان';

  @override
  String get noImageFound => 'لم يتم العثور على صورة';

  @override
  String get emptyDescription => ' ';

  @override
  String get favorite => 'المفضلة';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get switchLanguage => 'تبديل اللغة';

  static Future<AppLocalizationsAr> load(Locale locale) {
    return SynchronousFuture<AppLocalizationsAr>(const AppLocalizationsAr());
  }
}
