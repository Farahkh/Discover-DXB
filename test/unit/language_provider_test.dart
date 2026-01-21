import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dicover_dxb/providers/language_provider.dart';

/// UNIT TEST: LanguageProvider
/// 
/// PURPOSE:
/// This test file demonstrates how to test a ChangeNotifier provider that manages
/// application state (in this case, language selection).
///
/// THINKING PROCESS:
/// 1. Identify what the provider does:
///    - Stores current locale (language)
///    - Allows toggling between English and Arabic
///    - Allows setting a specific locale
///    - Notifies listeners when language changes
///
/// 2. Identify test scenarios:
///    - Initial state (should be English by default)
///    - Toggle language (English -> Arabic, Arabic -> English)
///    - Set locale explicitly
///    - Listener notification on state change
///
/// 3. Structure each test:
///    - ARRANGE: Set up the test conditions
///    - ACT: Perform the action being tested
///    - ASSERT: Verify the results

void main() {
  group('LanguageProvider - State Management Tests', () {
    // ARRANGE: Initialize provider before each test
    late LanguageProvider languageProvider;

    setUp(() {
      languageProvider = LanguageProvider();
    });

    /// TEST 1: Initial State
    /// 
    /// THINKING:
    /// - All providers should have a known initial state
    /// - This test verifies the default behavior (English language)
    /// - Important for ensuring the app starts in a predictable state
    test(
      'Should initialize with English locale as default',
      () {
        // ASSERT: Check the initial locale
        expect(
          languageProvider.locale.languageCode,
          equals('en'),
          reason: 'Default language should be English',
        );
      },
    );

    /// TEST 2: Toggle Language Functionality
    ///
    /// THINKING:
    /// - This is the core functionality - switching between languages
    /// - Test goes: English -> Arabic -> English to ensure bidirectional toggling
    /// - This is a critical path test (frequently used by users)
    test(
      'Should toggle language from English to Arabic and back',
      () {
        // Initial state is English
        expect(languageProvider.locale.languageCode, equals('en'));

        // ACT: Toggle to Arabic
        languageProvider.toggleLanguage();

        // ASSERT: Should be Arabic now
        expect(
          languageProvider.locale.languageCode,
          equals('ar'),
          reason: 'After first toggle, language should be Arabic',
        );

        // ACT: Toggle back to English
        languageProvider.toggleLanguage();

        // ASSERT: Should be English again
        expect(
          languageProvider.locale.languageCode,
          equals('en'),
          reason: 'After second toggle, language should be English again',
        );
      },
    );

    /// TEST 3: Set Specific Locale
    ///
    /// THINKING:
    /// - Users might need to programmatically set a language (e.g., from settings)
    /// - This tests the setLocale method independently
    /// - Good for testing explicit language selection
    test(
      'Should set locale to a specific language',
      () {
        final arabicLocale = Locale('ar');

        // ACT: Set locale to Arabic
        languageProvider.setLocale(arabicLocale);

        // ASSERT: Verify it's Arabic
        expect(
          languageProvider.locale.languageCode,
          equals('ar'),
          reason: 'Locale should be set to Arabic',
        );

        final englishLocale = Locale('en');

        // ACT: Set locale to English
        languageProvider.setLocale(englishLocale);

        // ASSERT: Verify it's English
        expect(
          languageProvider.locale.languageCode,
          equals('en'),
          reason: 'Locale should be set to English',
        );
      },
    );

    /// TEST 4: Listener Notification on Change
    ///
    /// THINKING:
    /// - ChangeNotifier must notify listeners when state changes
    /// - Without notifications, UI won't rebuild when language changes
    /// - This is critical for the reactive behavior of Flutter
    test(
      'Should notify listeners when language is toggled',
      () {
        // ARRANGE: Set up a listener callback
        var listenerCallCount = 0;
        languageProvider.addListener(() {
          listenerCallCount++;
        });

        // ACT: Toggle the language
        languageProvider.toggleLanguage();

        // ASSERT: Listener should have been called once
        expect(
          listenerCallCount,
          equals(1),
          reason: 'Listener should be called once when language toggles',
        );

        // ACT: Toggle again
        languageProvider.toggleLanguage();

        // ASSERT: Listener should have been called again
        expect(
          listenerCallCount,
          equals(2),
          reason: 'Listener should be called again on second toggle',
        );
      },
    );

    /// TEST 5: Setting Same Locale Should Not Notify
    ///
    /// THINKING:
    /// - Performance optimization: if setting the same language, don't rebuild UI
    /// - setLocale checks if locale is different before notifying
    /// - This prevents unnecessary widget rebuilds
    test(
      'Should not notify listeners when setting the same locale',
      () {
        // ARRANGE
        var listenerCallCount = 0;
        languageProvider.addListener(() {
          listenerCallCount++;
        });

        // ACT: Set to English (which is already the default)
        final englishLocale = Locale('en');
        languageProvider.setLocale(englishLocale);

        // ASSERT: Listener should NOT be called (optimization)
        expect(
          listenerCallCount,
          equals(0),
          reason: 'Setting same locale should not trigger listener',
        );
      },
    );

    /// TEST 6: Multiple State Transitions
    ///
    /// THINKING:
    /// - Real-world usage: users might toggle language multiple times
    /// - This tests that the provider maintains correct state through transitions
    /// - Catches edge cases like state corruption
    test(
      'Should maintain correct state through multiple language toggles',
      () {
        // Start: English
        expect(languageProvider.locale.languageCode, equals('en'));

        // Toggle sequence: En -> Ar -> En -> Ar -> En
        for (int i = 0; i < 5; i++) {
          languageProvider.toggleLanguage();
          final expectedLanguage = (i + 1) % 2 == 1 ? 'ar' : 'en';
          expect(
            languageProvider.locale.languageCode,
            equals(expectedLanguage),
            reason: 'State should be correct after $i toggles',
          );
        }
      },
    );
  });
}
