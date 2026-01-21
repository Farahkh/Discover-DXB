import 'package:flutter_test/flutter_test.dart';
import 'package:dicover_dxb/l10n/app_localizations.dart';
import 'package:dicover_dxb/l10n/app_localizations_en.dart';
import 'package:dicover_dxb/l10n/app_localizations_ar.dart';

/// UNIT TEST: App Localization Strings
///
/// PURPOSE:
/// This test file verifies that all localization strings are correctly implemented
/// for both supported languages (English and Arabic).
///
/// THINKING PROCESS:
/// 1. Why test localization separately from UI?
///    - Localization logic is independent business logic
///    - Strings can be tested without building full widgets
///    - Catches translation mistakes and missing strings early
///
/// 2. What to test?
///    - All required strings exist for each language
///    - No null or empty strings
///    - Correct translations (as much as possible to verify)
///    - Consistency in string availability across languages
///
/// 3. How to organize?
///    - Test English and Arabic implementations separately
///    - Then test consistency between both languages
///    - Use descriptive test names that explain what's being verified

void main() {
  group('AppLocalizations - String Translation Tests', () {
    
    /// TEST GROUP 1: English Localization
    group('English (en) Localization', () {
      late AppLocalizationsEn englishLocalizations;

      setUp(() {
        englishLocalizations = const AppLocalizationsEn();
      });

      /// THINKING:
      /// - Each UI element needs a corresponding string
      /// - Testing each string ensures nothing is forgotten
      /// - Good practice: test exact string values to catch typos
      
      test('Should have appTitle string', () {
        expect(
          englishLocalizations.appTitle,
          isNotEmpty,
          reason: 'appTitle should not be empty',
        );
        expect(
          englishLocalizations.appTitle,
          equals('Discover DXB'),
          reason: 'appTitle should be correct English translation',
        );
      });

      test('Should have discoverButton string', () {
        expect(
          englishLocalizations.discoverButton,
          isNotEmpty,
          reason: 'discoverButton should not be empty',
        );
        expect(
          englishLocalizations.discoverButton,
          equals('Discover'),
          reason: 'Button text should be "Discover"',
        );
      });

      test('Should have homePage string', () {
        expect(
          englishLocalizations.homePage,
          isNotEmpty,
          reason: 'homePage should not be empty',
        );
      });

      test('Should have directory string', () {
        expect(
          englishLocalizations.directory,
          isNotEmpty,
          reason: 'directory should not be empty',
        );
      });

      test('Should have language option strings', () {
        expect(englishLocalizations.english, isNotEmpty);
        expect(englishLocalizations.arabic, isNotEmpty);
      });

      /// TEST: All strings are present (not null)
      ///
      /// THINKING:
      /// - Comprehensive check that no strings are missing
      /// - If a developer forgets to add a translation, this catches it
      test('Should have all required strings defined', () {
        final strings = [
          englishLocalizations.appTitle,
          englishLocalizations.discoverButton,
          englishLocalizations.homePage,
          englishLocalizations.directory,
          englishLocalizations.english,
          englishLocalizations.arabic,
        ];

        for (final str in strings) {
          expect(
            str,
            isNotEmpty,
            reason: 'String should not be null or empty',
          );
        }
      });
    });

    /// TEST GROUP 2: Arabic Localization
    group('Arabic (ar) Localization', () {
      late AppLocalizationsAr arabicLocalizations;

      setUp(() {
        arabicLocalizations = const AppLocalizationsAr();
      });

      test('Should have appTitle in Arabic', () {
        expect(
          arabicLocalizations.appTitle,
          isNotEmpty,
          reason: 'appTitle should not be empty',
        );
        expect(
          arabicLocalizations.appTitle,
          equals('اكتشف دبي'),
          reason: 'appTitle should be correct Arabic translation',
        );
      });

      test('Should have discoverButton in Arabic', () {
        expect(
          arabicLocalizations.discoverButton,
          isNotEmpty,
          reason: 'discoverButton should not be empty',
        );
        expect(
          arabicLocalizations.discoverButton,
          equals('اكتشف'),
          reason: 'Button text should be "اكتشف"',
        );
      });

      test('Should have homePage in Arabic', () {
        expect(
          arabicLocalizations.homePage,
          equals('الصفحة الرئيسية'),
          reason: 'homePage should have correct Arabic translation',
        );
      });

      test('Should have directory in Arabic', () {
        expect(
          arabicLocalizations.directory,
          equals('الدليل'),
          reason: 'directory should have correct Arabic translation',
        );
      });

      test('Should have all required strings defined', () {
        final strings = [
          arabicLocalizations.appTitle,
          arabicLocalizations.discoverButton,
          arabicLocalizations.homePage,
          arabicLocalizations.directory,
          arabicLocalizations.english,
          arabicLocalizations.arabic,
        ];

        for (final str in strings) {
          expect(
            str,
            isNotEmpty,
            reason: 'String should not be null or empty',
          );
        }
      });
    });

    /// TEST GROUP 3: Localization Consistency
    group('Localization Consistency Checks', () {
      late AppLocalizationsEn englishLocalizations;
      late AppLocalizationsAr arabicLocalizations;

      setUp(() {
        englishLocalizations = const AppLocalizationsEn();
        arabicLocalizations = const AppLocalizationsAr();
      });

      /// TEST: Both languages have same set of strings
      ///
      /// THINKING:
      /// - If one language has a string, the other should too
      /// - Prevents situations where a feature only works in one language
      /// - This is a consistency check for localization completeness
      test(
        'Both languages should have the same set of localized strings',
        () {
          // Get all string keys by reflection-like approach
          // (We'll check key string properties exist in both)
          final englishStrings = [
            englishLocalizations.appTitle,
            englishLocalizations.discoverButton,
            englishLocalizations.homePage,
            englishLocalizations.directory,
          ];

          final arabicStrings = [
            arabicLocalizations.appTitle,
            arabicLocalizations.discoverButton,
            arabicLocalizations.homePage,
            arabicLocalizations.directory,
          ];

          // Both should have same number of strings
          expect(
            englishStrings.length,
            equals(arabicStrings.length),
            reason: 'Both languages should have same number of strings',
          );

          // All strings should be non-empty
          expect(englishStrings.every((s) => s.isNotEmpty), isTrue);
          expect(arabicStrings.every((s) => s.isNotEmpty), isTrue);
        },
      );

      /// TEST: Strings are different between languages
      ///
      /// THINKING:
      /// - Sanity check that we actually translated strings
      /// - If English and Arabic are the same, translation failed
      test(
        'English and Arabic translations should be different',
        () {
          expect(
            englishLocalizations.appTitle,
            isNot(equals(arabicLocalizations.appTitle)),
            reason: 'appTitle should be translated differently',
          );

          expect(
            englishLocalizations.discoverButton,
            isNot(equals(arabicLocalizations.discoverButton)),
            reason: 'discoverButton should be translated differently',
          );
        },
      );

      /// TEST: Check for common translation mistakes
      ///
      /// THINKING:
      /// - Developers sometimes forget to translate and leave English text
      /// - This checks for untranslated content in Arabic
      test(
        'Arabic strings should not contain English app title',
        () {
          expect(
            arabicLocalizations.appTitle.contains('Discover'),
            isFalse,
            reason: 'Arabic translation should not contain English text',
          );
        },
      );
    });

    /// TEST GROUP 4: Localization Delegate
    group('AppLocalizations Delegate', () {
      
      /// TEST: Supported locales are correctly defined
      ///
      /// THINKING:
      /// - The delegate must declare all supported languages
      /// - Flutter uses this to determine if a locale is supported
      /// - Missing locales here means those languages won't work
      test(
        'Should declare both English and Arabic as supported locales',
        () {
          final supportedLocales = AppLocalizations.supportedLocales;

          expect(supportedLocales, isNotEmpty, reason: 'Should have supported locales');
          expect(
            supportedLocales.map((l) => l.languageCode).toList(),
            containsAll(['en', 'ar']),
            reason: 'Should support English and Arabic',
          );
        },
      );

      /// TEST: Localization delegates are properly configured
      ///
      /// THINKING:
      /// - Delegate list must include AppLocalizations delegate
      /// - Must also include Flutter's built-in localizations
      /// - Missing delegates means Material Design won't localize
      test(
        'Should have proper localization delegates configured',
        () {
          final delegates = AppLocalizations.localizationsDelegates;

          expect(delegates, isNotEmpty, reason: 'Should have delegates');
          expect(
            delegates.length,
            greaterThanOrEqualTo(4),
            reason: 'Should have at least 4 delegates (AppLocalizations + 3 Flutter delegates)',
          );
        },
      );
    });
  });
}
