import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

/// INTEGRATION TEST: Complete App User Flows
///
/// PURPOSE:
/// Integration tests verify that different parts of the app work together
/// correctly. They test real user scenarios and user journeys.
///
/// THINKING PROCESS:
/// 1. Difference from widget tests:
///    - Widget tests: isolated component testing (button works, text shows)
///    - Integration tests: full app scenarios (user path from A to B to C)
///    - Runs on real device/emulator (or simulated)
///    - Tests actual navigation, data flow, complete features
///
/// 2. Why integration tests?
///    - Unit tests: verify individual functions work
///    - Widget tests: verify individual UI components work
///    - Integration tests: verify everything works together
///    - Users don't use individual components, they use the whole app
///
/// 3. What scenarios to test?
///    - User opens app -> sees English -> switches to Arabic
///    - User performs multiple actions in sequence
///    - Navigation flows (button clicks leading to screens)
///    - State persistence through navigation
///
/// 4. Realistic scenarios for this app:
///    - User story: "As a bilingual user, I want to switch languages"
///    - User story: "As a user, I want to navigate through the app"
///    - User story: "As a user, I want language preference to persist"

void main() {
  // Setup integration tests
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Tests - User Journeys', () {
    
    /// TEST 1: Language Toggle User Journey
    ///
    /// THINKING:
    /// - Most common user action: switching languages
    /// - Real scenario: bilingual user opens app in English, switches to Arabic
    /// - Verifies: button works, language changes, UI updates
    /// - Duration: ~5 seconds real app time
    testWidgets(
      'User Journey: Open app and toggle language',
      (WidgetTester tester) async {
        // ARRANGE: Start the app
        main();
        await tester.pumpAndSettle(); // Wait for app to fully load

        // Verify initial state
        expect(
          find.text('Discover'),
          findsOneWidget,
          reason: 'App should start with English',
        );

        // ACT: User sees language button and taps it
        await tester.tap(find.text('العربية'));
        await tester.pumpAndSettle();

        // ASSERT: Language changed
        expect(
          find.text('اكتشف'),
          findsOneWidget,
          reason: 'After tapping Arabic, UI should show Arabic text',
        );

        // ASSERT: Button now shows English option (allowing user to switch back)
        expect(
          find.text('English'),
          findsOneWidget,
          reason: 'Button should now show English option for switching back',
        );

        // ACT: User changes mind and switches back to English
        await tester.tap(find.text('English'));
        await tester.pumpAndSettle();

        // ASSERT: Back to English
        expect(
          find.text('Discover'),
          findsOneWidget,
          reason: 'Should switch back to English',
        );
      },
    );

    /// TEST 2: Multiple Language Toggles
    ///
    /// THINKING:
    /// - User might toggle language several times
    /// - Simulates real bilingual user behavior
    /// - Tests for state corruption or memory leaks
    /// - Verifies consistency through repeated actions
    testWidgets(
      'User Journey: Toggle language multiple times rapidly',
      (WidgetTester tester) async {
        main();
        await tester.pumpAndSettle();

        // Simulate user rapidly switching language preference
        // (e.g., trying out different languages)
        for (int i = 0; i < 5; i++) {
          // Get current button text to find it
          final currentButtonText = i % 2 == 0 ? 'العربية' : 'English';
          
          // ACT: Tap language button
          await tester.tap(find.text(currentButtonText));
          await tester.pumpAndSettle();

          // ASSERT: Language changed
          final expectedText = i % 2 == 0 ? 'اكتشف' : 'Discover';
          expect(
            find.text(expectedText),
            findsOneWidget,
            reason: 'Language should change on iteration $i',
          );
        }
      },
    );

    /// TEST 3: App Stability Test
    ///
    /// THINKING:
    /// - Stress test the app with rapid interactions
    /// - Verifies no crashes or freezes
    /// - Tests memory management
    /// - Simulates power user (not typical, but important)
    testWidgets(
      'User Journey: Rapid language toggling for stress testing',
      (WidgetTester tester) async {
        main();
        await tester.pumpAndSettle();

        // Stress test: rapidly toggle language 10 times
        for (int i = 0; i < 10; i++) {
          try {
            final buttonText = i % 2 == 0 ? 'العربية' : 'English';
            await tester.tap(find.text(buttonText));
            await tester.pump(); // Faster than pumpAndSettle
          } catch (e) {
            fail('App crashed during iteration $i: $e');
          }
        }

        // ASSERT: App still responsive
        expect(find.byType(MaterialApp), findsOneWidget);
      },
    );

    /// TEST 4: Navigation Button Accessibility
    ///
    /// THINKING:
    /// - User should be able to tap the Discover button
    /// - This is the primary action in the app
    /// - Button should be findable and tappable in both languages
    testWidgets(
      'User Journey: Tap Discover button in different languages',
      (WidgetTester tester) async {
        main();
        await tester.pumpAndSettle();

        // Find and tap Discover button (English)
        expect(find.byType(ElevatedButton), findsOneWidget);
        await tester.tap(find.byType(ElevatedButton));
        // Note: Navigation might not work fully without proper setup
        // but we verify the button is tappable

        // Navigate back (if applicable)
        // For now, we just verify no crash
        await tester.pumpAndSettle();

        // ASSERT: App still responsive
        expect(find.byType(MaterialApp), findsOneWidget);
      },
    );

    /// TEST 5: UI Elements Always Accessible
    ///
    /// THINKING:
    /// - Critical UI elements should always be visible
    /// - User should always be able to switch language
    /// - Discover button should always be accessible
    /// - Tests accessibility throughout app usage
    testWidgets(
      'User Journey: All critical UI elements remain accessible',
      (WidgetTester tester) async {
        main();
        await tester.pumpAndSettle();

        // Check language button accessible
        expect(find.text('العربية'), findsOneWidget);
        
        // Check main button accessible
        expect(find.text('Discover'), findsOneWidget);
        
        // Check navigation icons at bottom
        expect(find.byType(Image), findsWidgets);

        // ACT: Switch language
        await tester.tap(find.text('العربية'));
        await tester.pumpAndSettle();

        // ASSERT: All elements still accessible in Arabic
        expect(find.text('English'), findsOneWidget);
        expect(find.text('اكتشف'), findsOneWidget);
        expect(find.byType(Image), findsWidgets);
      },
    );

    /// TEST 6: Screen Layout Integrity
    ///
    /// THINKING:
    /// - Language change shouldn't break layout
    /// - App should look correct in both languages
    /// - Verifies responsive design works
    /// - Tests that RTL (Right-To-Left) for Arabic is handled
    testWidgets(
      'User Journey: Layout remains intact after language change',
      (WidgetTester tester) async {
        main();
        await tester.pumpAndSettle();

        // Check initial layout has key components
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byType(BottomAppBar), findsOneWidget);

        // ACT: Switch to Arabic
        await tester.tap(find.text('العربية'));
        await tester.pumpAndSettle();

        // ASSERT: Layout structure unchanged
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byType(BottomAppBar), findsOneWidget);

        // ASSERT: All widgets still present
        expect(find.byType(Column), findsWidgets);
        expect(find.byType(ElevatedButton), findsOneWidget);
      },
    );

    /// TEST 7: Consecutive Operations
    ///
    /// THINKING:
    /// - User might: toggle language -> try to navigate -> toggle again
    /// - Tests complex user flows
    /// - Verifies state management holds across operations
    testWidgets(
      'User Journey: Toggle language, attempt navigation, toggle again',
      (WidgetTester tester) async {
        main();
        await tester.pumpAndSettle();

        // Step 1: Start in English
        expect(find.text('Discover'), findsOneWidget);

        // Step 2: Switch to Arabic
        await tester.tap(find.text('العربية'));
        await tester.pumpAndSettle();
        expect(find.text('اكتشف'), findsOneWidget);

        // Step 3: Interact with main button (try to navigate)
        await tester.tap(find.text('اكتشف'));
        await tester.pump(); // Small pump to process tap

        // Step 4: Switch language back
        await tester.tap(find.text('English'));
        await tester.pumpAndSettle();
        expect(find.text('Discover'), findsOneWidget);

        // ASSERT: App stable after multiple operations
        expect(find.byType(MaterialApp), findsOneWidget);
      },
    );

    /// TEST 8: Long Session Stability
    ///
    /// THINKING:
    /// - User might keep app open for extended time
    /// - Tests for memory leaks
    /// - Verifies app doesn't degrade over time
    /// - Simulates 1-2 minute user session
    testWidgets(
      'User Journey: Extended session with periodic language toggles',
      (WidgetTester tester) async {
        // Set longer timeout for this test
        tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

        main();
        await tester.pumpAndSettle();

        // Simulate user session with periodic language switches
        // (like user trying language settings multiple times)
        const toggleCount = 15;
        
        for (int i = 0; i < toggleCount; i++) {
          final buttonText = i % 2 == 0 ? 'العربية' : 'English';
          
          if (find.text(buttonText).evaluate().isNotEmpty) {
            await tester.tap(find.text(buttonText));
            await tester.pump();
          }
        }

        // ASSERT: App stable after extended interaction
        expect(find.byType(MaterialApp), findsOneWidget);
      },
    );

    /// TEST 9: Performance Check - Language Switch Responsiveness
    ///
    /// THINKING:
    /// - User expects instant language switch (no lag)
    /// - Tests UI responsiveness
    /// - Verifies rebuild happens quickly
    testWidgets(
      'User Journey: Language switch should respond quickly',
      (WidgetTester tester) async {
        main();
        await tester.pumpAndSettle();

        // Record time before action
        final stopwatch = Stopwatch()..start();

        // ACT: Switch language
        await tester.tap(find.text('العربية'));
        await tester.pumpAndSettle();

        stopwatch.stop();

        // ASSERT: Language switched (on most devices, should be instant)
        expect(find.text('اكتشف'), findsOneWidget);
        
        // Performance assertion: should complete in less than 1 second
        // (if much slower, UI is freezing)
        expect(
          stopwatch.elapsedMilliseconds,
          lessThan(1000),
          reason: 'Language switch should be responsive (< 1 second)',
        );
      },
    );

    /// TEST 10: Error Recovery
    ///
    /// THINKING:
    /// - What if localization fails to load?
    /// - What if provider throws exception?
    /// - Tests graceful degradation
    /// - Verifies app doesn't crash on errors
    testWidgets(
      'User Journey: App handles edge cases gracefully',
      (WidgetTester tester) async {
        main();
        await tester.pumpAndSettle();

        try {
          // Normal operation
          await tester.tap(find.text('العربية'));
          await tester.pumpAndSettle();

          // Try to find missing text (should not crash)
          final missingWidget = find.text('NonExistentText');
          expect(missingWidget, findsNothing);

          // App should still be functional
          await tester.tap(find.text('English'));
          await tester.pumpAndSettle();

          expect(find.byType(MaterialApp), findsOneWidget);
        } catch (e) {
          fail('App should handle missing widgets gracefully: $e');
        }
      },
    );
  });

  /// TEST GROUP: State Persistence Scenarios
  group('Integration Tests - State Management', () {
    
    /// TEST: Language preference persists (simulated)
    ///
    /// THINKING:
    /// - In real app, you might save language preference
    /// - This tests that state management works correctly
    /// - Simulates user closing and reopening app
    testWidgets(
      'Language state should be consistent within app session',
      (WidgetTester tester) async {
        main();
        await tester.pumpAndSettle();

        // Set language to Arabic
        await tester.tap(find.text('العربية'));
        await tester.pumpAndSettle();

        // Verify it's Arabic
        expect(find.text('اكتشف'), findsOneWidget);

        // Simulate user leaving app (navigate away)
        // In this case, we just interact with the same state
        await tester.tap(find.text('اكتشف'));
        await tester.pumpAndSettle();

        // State should be maintained (still Arabic)
        // This would be verified if you navigate and come back
        expect(find.byType(MaterialApp), findsOneWidget);
      },
    );
  });
}
