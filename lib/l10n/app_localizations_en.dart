import 'package:flutter/material.dart';
import 'app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  const AppLocalizationsEn();
  @override
  String get appTitle => 'Discover DXB';

  @override
  String get discoverButton => 'Discover';

  @override
  String get homePage => 'Home Page';

  @override
  String get directory => 'Directory';

  @override
  String get english => 'English';

  @override
  String get arabic => 'العربية';

  @override
  String get discoverDxbDirectory => 'Discover DXB Directory';

  @override
  String get dubai => 'Dubai';

  @override
  String get abuDhabi => 'Abu Dhabi';

  @override
  String get sharjah => 'Sharjah';

  @override
  String get burjKhalifa => 'Burj Khalifa';

  @override
  String get burjKhalifaDescription => 'The tallest building in the world located in Dubai.';

  @override
  String get dubaiMall => 'The Dubai Mall';

  @override
  String get dubaiMallDescription => 'One of the largest shopping malls in the world.';

  @override
  String get palmJumeirah => 'Palm Jumeirah';

  @override
  String get palmJumeirahDescription => 'A palm inside the sea, known for its luxury hotels and residences.';

  @override
  String get noTitle => 'No Title';

  @override
  String get noImageFound => 'no image found';

  @override
  String get emptyDescription => ' ';

  @override
  String get favorite => 'Favorite';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get switchLanguage => 'Switch Language';

  static Future<AppLocalizationsEn> load(Locale locale) {
    return SynchronousFuture<AppLocalizationsEn>(const AppLocalizationsEn());
  }
}
