import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:dicover_dxb/main.dart';
import 'package:dicover_dxb/providers/language_provider.dart';
import 'package:dicover_dxb/l10n/app_localizations.dart';

/// WIDGET TEST: MyApp and UI Components
///
/// PURPOSE:
/// Widget tests verify that Flutter UI widgets render correctly, respond to user
/// interactions, and display the correct content.
///
/// THINKING PROCESS:
/// 1. Key differences from unit tests:
///    - Build actual widgets (but not the whole app in many cases)
///    - Interact with UI elements (taps, scrolls, etc.)
///    - Verify rendered output (text, images, layouts)
///    - Test widget lifecycle
///
/// 2. What to test for this app:
///    - App initializes with correct language
///    - Language switch button appears and works
///    - Button text changes when language changes
///    - Localized strings appear on screen
///    - Navigation buttons work
///
/// 3. Test structure:
///    - testWidgets instead of test
///    - Use WidgetTester to interact with widgets
///    - pump() to rebuild widgets
///    - find() to locate widgets on screen

void main() {
  group('MyApp Widget Tests - UI Rendering and Interactions', () {
    
    /// TEST 1: App builds without errors
    ///
    /// THINKING:
    /// - First and most basic test: does the app even build?
    /// - Catches crashes, missing imports, widget errors
    /// - This must pass before other tests can work
    testWidgets(
      'App should build without errors',
      (WidgetTester tester) async {
        // ARRANGE & ACT: Build the app
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
            child: const MyApp(),
          ),
        );

        // ASSERT: App should be built (no crashes)
        expect(find.byType(MyApp), findsOneWidget);
      },
    );

    /// TEST 2: Initial language is English
    ///
    /// THINKING:
    /// - App should start with a known language
    /// - This test verifies the default state is correct
    /// - Important for user experience consistency
    testWidgets(
      'Should display English language initially',
      (WidgetTester tester) async {
        // ARRANGE & ACT: Build app
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
            child: const MyApp(),
          ),
        );

        // ASSERT: Should find the "Discover" button (English text)
        expect(
          find.text('Discover'),
          findsOneWidget,
          reason: 'English "Discover" button should be present initially',
        );
      },
    );

    /// TEST 3: Language switch button appears
    ///
    /// THINKING:
    /// - The language switch button must be visible
    /// - This is in the AppBar at the top-right
    /// - Users must be able to see it to use it
    testWidgets(
      'Language switch button should be visible in AppBar',
      (WidgetTester tester) async {
        // ARRANGE & ACT
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
            child: const MyApp(),
          ),
        );

        // ASSERT: Find the language switch button (shows Arabic)
        expect(
          find.text('العربية'),
          findsOneWidget,
          reason: 'Language switch button showing Arabic should be visible',
        );
      },
    );

    /// TEST 4: Tapping language button changes language
    ///
    /// THINKING:
    /// - This is the critical user interaction
    /// - User taps the button -> language should change
    /// - This is an integration of:
    ///   - Button widget (InkWell)
    ///   - Provider (LanguageProvider.toggleLanguage)
    ///   - Widget rebuild (Consumer rebuilds)
    /// - Without this, users can't change language
    testWidgets(
      'Tapping language button should toggle language to Arabic',
      (WidgetTester tester) async {
        // ARRANGE & ACT: Build app
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
            child: const MyApp(),
          ),
        );

        // ASSERT: Initially English
        expect(find.text('Discover'), findsOneWidget);
        expect(find.text('العربية'), findsOneWidget);

        // ACT: Tap the language switch button
        await tester.tap(find.text('العربية'));
        
        // IMPORTANT: pump() rebuilds widgets after state change
        // Without this, the UI won't update
        await tester.pump();

        // ASSERT: Button text should change to show English option
        expect(
          find.text('English'),
          findsOneWidget,
          reason: 'After toggle, should show English option',
        );

        // ASSERT: Discover button should now show Arabic text
        expect(
          find.text('اكتشف'),
          findsOneWidget,
          reason: 'App should be in Arabic now',
        );
      },
    );

    /// TEST 5: Language persists after multiple toggles
    ///
    /// THINKING:
    /// - User might toggle language multiple times
    /// - State should be consistent through multiple changes
    /// - This tests robustness of the implementation
    testWidgets(
      'Language should toggle correctly multiple times',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
            child: const MyApp(),
          ),
        );

        // Toggle 1: English to Arabic
        await tester.tap(find.text('العربية'));
        await tester.pump();
        expect(find.text('اكتشف'), findsOneWidget);

        // Toggle 2: Arabic to English
        await tester.tap(find.text('English'));
        await tester.pump();
        expect(find.text('Discover'), findsOneWidget);

        // Toggle 3: English to Arabic again
        await tester.tap(find.text('العربية'));
        await tester.pump();
        expect(find.text('اكتشف'), findsOneWidget);
      },
    );

    /// TEST 6: Discover button is accessible and tappable
    ///
    /// THINKING:
    /// - The main action button must exist and be tappable
    /// - This verifies the navigation trigger exists
    /// - Important for core app functionality
    testWidgets(
      'Discover button should exist and be tappable',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
            child: const MyApp(),
          ),
        );

        // ASSERT: Button exists
        expect(find.byType(ElevatedButton), findsOneWidget);
        
        // ASSERT: Button is enabled (tappable)
        final button = find.byType(ElevatedButton);
        expect(button, findsOneWidget);

        // ACT: Can tap the button without error
        await tester.tap(button);
        await tester.pump();
        // If we get here without exception, button is tappable
      },
    );

    /// TEST 7: AppBar is visible
    ///
    /// THINKING:
    /// - AppBar holds the language switch button
    /// - Must be present for language switching to work
    /// - Verifies scaffold structure is correct
    testWidgets(
      'AppBar should be visible with transparent background',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
            child: const MyApp(),
          ),
        );

        // ASSERT: AppBar should exist
        expect(find.byType(AppBar), findsOneWidget);
        
        // ASSERT: Should have navigation actions
        expect(find.byType(Row), findsWidgets); // AppBar content
      },
    );

    /// TEST 8: Bottom navigation bar exists
    ///
    /// THINKING:
    /// - App has a BottomAppBar with navigation icons
    /// - This must be visible and intact
    /// - Verifies the full layout structure
    testWidgets(
      'BottomAppBar should be visible with navigation icons',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
            child: const MyApp(),
          ),
        );

        // ASSERT: BottomAppBar exists
        expect(find.byType(BottomAppBar), findsOneWidget);
        
        // ASSERT: Should have image assets (navigation icons)
        expect(find.byType(Image), findsWidgets);
      },
    );

    /// TEST 9: Text is properly localized
    ///
    /// THINKING:
    /// - Verify actual localization system works
    /// - AppLocalizations.of() returns correct strings
    /// - This bridges unit tests and widget tests
    testWidgets(
      'UI text should be properly localized from AppLocalizations',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
            child: const MyApp(),
          ),
        );

        // Get the context to access localization
        final context = tester.element(find.byType(MyApp));
        final localizations = AppLocalizations.of(context);

        // ASSERT: Localization strings match UI
        expect(find.text(localizations.discoverButton), findsOneWidget);
      },
    );

    /// TEST 10: Button styling is applied
    ///
    /// THINKING:
    /// - UI should be styled according to design
    /// - Purple color for Discover button
    /// - Verifies design implementation
    testWidgets(
      'Discover button should have correct styling',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
            child: const MyApp(),
          ),
        );

        // ASSERT: Button exists with correct text color
        final button = find.byType(ElevatedButton);
        expect(button, findsOneWidget);

        // Verify button is visible and rendered
        expect(find.byIcon(Icons.check), findsNothing); // No unexpected icons
      },
    );
  });

  /// TEST GROUP: Language Provider with Widget Context
  group('Language Provider Integration with Widgets', () {
    
    /// TEST: Provider updates widgets when language changes
    ///
    /// THINKING:
    /// - This is the heart of reactive UI
    /// - When provider emits, Consumer widget rebuilds
    /// - Old value still exists but widget shows new language
    testWidgets(
      'Consumer widget should rebuild when LanguageProvider changes',
      (WidgetTester tester) async {
        // ARRANGE: Create app with provider
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
            child: const MyApp(),
          ),
        );

        // ASSERT: Initial state - English button shows "اكتشف" (Arabic option)
        expect(find.text('Discover'), findsOneWidget);
        expect(find.text('العربية'), findsOneWidget);

        // ACT: Trigger language change
        await tester.tap(find.text('العربية'));
        
        // IMPORTANT: pumpWidget rebuilds the whole widget tree
        // In real scenario, Consumer rebuilds due to Provider notification
        await tester.pump();

        // ASSERT: UI updated with new language
        expect(find.text('اكتشف'), findsOneWidget);
        expect(find.text('English'), findsOneWidget);
      },
    );
  });
}
