# Integration Testing Challenges for Students

## Overview
This document contains three progressive challenges designed to help students understand integration testing in Flutter. Each challenge builds on the previous one and requires students to understand and modify the integration test code.

---

## Challenge 1: The Detective Challenge
**Difficulty Level:** ⭐ Beginner  
**Time Estimate:** 15-20 minutes

### Objective
Understand what each integration test does by analyzing the code and predicting its behavior.

### Instructions

1. **Read and Understand**: Open the file `integration_test/app_test.dart` and read the first 3 test cases:
   - "User Journey: Open app and toggle language"
   - "User Journey: Toggle language multiple times rapidly"
   - "User Journey: Long session with periodic language toggles"

2. **Answer These Questions**:

   **Question 1.1**: In the test "User Journey: Open app and toggle language", what is the **exact sequence** of actions the user performs?
   
   ```
   Write the sequence as numbered steps:
   Step 1: ...
   Step 2: ...
   Step 3: ...
   Step 4: ...
   (Continue until the end of the test)
   ```

   **Question 1.2**: What does `await tester.pumpAndSettle()` do? Why is it important?
   
   ```
   Your answer: _________________________________
   ```

   **Question 1.3**: Look at the test "Toggle language multiple times rapidly". What is it testing?
   
   ```
   A) Testing if the app crashes
   B) Testing if language changes multiple times
   C) Testing if the button is styled correctly
   D) Testing if the app shows ads
   
   Answer: ___
   ```

   **Question 1.4**: In "User Journey: App Stability Test", what happens in the for loop? What could happen if this test fails?
   
   ```
   What happens:
   _________________________________
   
   If it fails, it means:
   _________________________________
   ```

3. **Prediction Task**: 
   
   Look at this test code:
   ```dart
   testWidgets('User Journey: Tap Discover button in different languages', 
     (WidgetTester tester) async {
       app.main();
       await tester.pumpAndSettle();
       
       expect(find.byType(ElevatedButton), findsOneWidget);
       await tester.tap(find.byType(ElevatedButton));
       await tester.pumpAndSettle();
       
       expect(find.byType(MaterialApp), findsOneWidget);
     });
   ```
   
   **Predict**: What will happen when this test runs? Will it pass or fail? Why?
   
   ```
   Prediction:
   _________________________________
   _________________________________
   ```


---

## Challenge 2: The Bug Hunter Challenge
**Difficulty Level:** ⭐⭐ Intermediate  
**Time Estimate:** 20-30 minutes

### Objective
Identify problems in test code and understand why good tests are structured properly.

### Instructions

1. **The Broken Tests**: Below are 5 test code snippets. Each has a **problem** that would cause it to fail or not test properly. Identify the problem and explain why it's wrong.

### Broken Test #1
```dart
testWidgets('User toggles language to Arabic', (WidgetTester tester) async {
  app.main();
  
  // BUG: What's missing here?
  expect(find.text('اكتشف'), findsOneWidget);
});
```

**Question 2.1**: What is wrong with this test? What should be added?
```
The problem:
_________________________________

What's missing:
_________________________________

Why it matters:
_________________________________
```

---

### Broken Test #2
```dart
testWidgets('Multiple button taps', (WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle();
  
  // BUG: This test has a logic error
  for (int i = 0; i < 5; i++) {
    await tester.tap(find.text('العربية'));
    // What's missing?
  }
  
  expect(find.text('Discover'), findsOneWidget);
});
```

**Question 2.2**: What is wrong with this test? Explain the problem.
```
The problem:
_________________________________

Why the test might fail:
_________________________________

How to fix it:
_________________________________
```

---

### Broken Test #3
```dart
testWidgets('Language button visibility', (WidgetTester tester) async {
  // BUG: Test doesn't build the app
  
  expect(find.text('العربية'), findsOneWidget);
});
```

**Question 2.3**: Why will this test fail? What's the simplest fix?
```
Why it fails:
_________________________________

The fix:
_________________________________
```

---

### Broken Test #4
```dart
testWidgets('Stress test', (WidgetTester tester) async {
  app.main();
  
  // BUG: Infinite loop!
  for (int i = 0; i < 1000000; i++) {
    final buttonText = i % 2 == 0 ? 'العربية' : 'English';
    await tester.tap(find.text(buttonText));
    await tester.pumpAndSettle();
  }
  
  expect(find.byType(MaterialApp), findsOneWidget);
});
```

**Question 2.4**: What's the practical problem with this test, even though the code is technically correct?
```
The problem:
_________________________________

Why it matters in real testing:
_________________________________

How to improve it:
_________________________________
```

---

### Broken Test #5
```dart
testWidgets('Multiple assertions', (WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle();
  
  // BUG: Too many unrelated assertions
  expect(find.text('Discover'), findsOneWidget);
  expect(find.byType(Scaffold), findsOneWidget);
  expect(find.byType(AppBar), findsOneWidget);
  expect(find.byType(BottomAppBar), findsOneWidget);
  expect(find.byType(ElevatedButton), findsOneWidget);
  expect(find.byType(Column), findsWidgets);
  expect(find.byType(Row), findsWidgets);
});
```

**Question 2.5**: This test has valid code, but a testing philosophy issue. What's wrong?
```
The testing issue:
_________________________________

Why it's a problem:
_________________________________

How to improve it:
_________________________________
```

---

### Challenge #2 - Creative Task

**Question 2.6**: Write a test that:
1. Opens the app
2. Waits for it to load
3. Verifies initial state is English
4. Switches to Arabic
5. Taps the Discover button (in Arabic)
6. Verifies the button was tappable (app didn't crash)

```dart
testWidgets('User toggles language and taps discover button', 
  (WidgetTester tester) async {
    // YOUR CODE HERE
    
    
  });
```



---

## Challenge 3: The Code Modifier Challenge
**Difficulty Level:** ⭐⭐⭐ Advanced  
**Time Estimate:** 30-45 minutes

### Objective
Modify real integration tests to add new test cases and understand how to design tests.

### Part A: Extend Existing Functionality

**Question 3.1**: Add a new test case called "User Journey: Language persists after button click" that:
1. Starts the app
2. Switches to Arabic
3. Clicks the Discover button
4. Verifies the app is still in Arabic (not switched back to English)

```dart
testWidgets('User Journey: Language persists after button click', 
  (WidgetTester tester) async {
    // YOUR CODE HERE
    
    
  });
```

**Thinking Questions**:
- Why is this test important? What does it verify?
- What would happen if language switched back to English after navigation?
- How does this relate to state management?

---

### Part B: Design a New Test Scenario

**Question 3.2**: Look at the real user scenario:

```
A bilingual user (English-Arabic speaker) uses the app:
1. Opens app (in English)
2. Reads some content
3. Realizes they prefer Arabic
4. Switches to Arabic
5. Clicks Discover button to explore Dubai landmarks
6. Views a landmark in Arabic
7. Goes back to home
8. Switches to English to show a friend
```

Design an integration test that covers steps 1-8. Consider:
- Which screen/widget changes happen at each step?
- What should you assert at each step?
- Are there any critical points that could fail?

```dart
testWidgets('User Journey: Bilingual user explores landmarks', 
  (WidgetTester tester) async {
    // Step 1-2: App opens in English
    
    
    // Step 3-4: Switch to Arabic
    
    
    // Step 5: Click Discover button
    
    
    // Step 6-8: Verify app still works and can switch back
    
    
  });
```

---

### Part C: Test Edge Cases

**Question 3.3**: The current tests don't cover some edge cases. Design tests for:

1. **What if device orientation changes while app is in Arabic?**
   ```dart
   testWidgets('App should handle screen rotation in Arabic', 
     (WidgetTester tester) async {
       // YOUR TEST HERE
     });
   ```

2. **What if user taps language button very quickly twice?**
   ```dart
   testWidgets('Double tap language button should toggle twice', 
     (WidgetTester tester) async {
       // YOUR TEST HERE
     });
   ```

3. **What if app is in background and resumed?**
   - Note: This might not be possible with standard integration tests
   - Research: How would you test app lifecycle events?
   ```
   Your research:
   _________________________________
   ```

---

### Part D: Performance Analysis

**Question 3.4**: Look at this test performance data:

```
Test Results:
- "Language toggle" test: 245ms
- "Multiple toggles" test: 1,200ms
- "Extended session" test: 8,500ms
- "Stress test" test: 45,000ms (45 seconds!)
```

**Analysis Questions**:

1. Which test is taking too long? Why?
```
Answer:
_________________________________
```

2. What's a reasonable time limit for an integration test?
```
Answer:
_________________________________
```

3. How would you optimize the slow test?
```
Answer:
_________________________________
```

---

### Part E: Critical Thinking

**Question 3.5**: Look at this test:

```dart
testWidgets('User can toggle language and tap button', 
  (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    
    // Toggle language
    await tester.tap(find.text('العربية'));
    await tester.pump();
    
    // Tap button
    await tester.tap(find.text('اكتشف'));
    await tester.pump();
    
    // This always passes
    expect(true, isTrue);
  });
```

**Critical Questions**:

1. What is wrong with the assertion `expect(true, isTrue)`?
```
The problem:
_________________________________

Why it's bad:
_________________________________

How to fix it:
_________________________________
```

2. What should we actually assert to verify the user's actions worked?
```
Better assertions:
_________________________________
_________________________________
```

3. Design a "bad test" that looks like it's testing something but actually isn't:
```dart
testWidgets('Bad test example', (WidgetTester tester) async {
  // Write a test that looks good but doesn't actually test anything
  
  
});
```

---

## Challenge 3 Expected Answers (For Teachers)

### 3.1 Answer:
```dart
testWidgets('User Journey: Language persists after button click', 
  (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    
    // Switch to Arabic
    await tester.tap(find.text('العربية'));
    await tester.pumpAndSettle();
    expect(find.text('اكتشف'), findsOneWidget);
    
    // Click discover button
    await tester.tap(find.text('اكتشف'));
    await tester.pump();
    
    // Language should still be Arabic (button should show English option)
    expect(find.text('English'), findsOneWidget);
  });
```



