# Discover DXB - A Localized Flutter Application

A comprehensive Flutter application demonstrating localization (English/Arabic), state management with Provider, and complete testing coverage (Unit, Widget, and Integration tests).

## Features

✨ **Multi-Language Support**
- English and Arabic localization
- Language toggle button in the app bar
- RTL (Right-to-Left) support for Arabic
- Persistent language selection within app session

🎨 **UI/UX**
- Material Design 3
- Responsive layout
- Beautiful gradient backgrounds
- Interactive buttons and navigation

📱 **State Management**
- Provider pattern for language state management
- ChangeNotifier for reactive updates
- Clean separation of concerns

🧪 **Comprehensive Testing**
- **Unit Tests** (60%): LanguageProvider and localization logic
- **Widget Tests** (30%): UI components and interactions
- **Integration Tests** (10%): Complete user journeys
- See [TEST_DOCUMENTATION.md](TEST_DOCUMENTATION.md) for detailed testing guide
- See [STUDENT_CHALLENGES.md](STUDENT_CHALLENGES.md) for learning challenges

## Project Structure

```
lib/
├── main.dart                          # App entry point with Provider setup
├── directory.dart                     # Directory listing screen
├── single_page.dart                   # Detail screen for landmarks
├── providers/
│   └── language_provider.dart         # Language state management
└── l10n/
    ├── app_localizations.dart         # Localization base class
    ├── app_localizations_en.dart      # English implementation
    ├── app_localizations_ar.dart      # Arabic implementation
    ├── app_en.arb                     # English strings
    └── app_ar.arb                     # Arabic strings

test/
├── unit/
│   ├── language_provider_test.dart    # Provider unit tests
│   └── app_localizations_test.dart    # Localization unit tests
└── widget/
    └── my_app_test.dart               # App widget tests

integration_test/
└── app_test.dart                      # Integration tests (user journeys)
```

## Getting Started

### Prerequisites
- Flutter SDK (3.6.0 or higher)
- Dart SDK
- Android Studio / Xcode (for emulator)
- Git

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/discover-dxb.git
cd discover-dxb
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

### Running Tests

```bash
# Run all tests
flutter test

# Run unit tests only
flutter test test/unit/

# Run widget tests only
flutter test test/widget/

# Run integration tests
flutter test integration_test/app_test.dart

# Run with coverage
flutter test --coverage
```

## Architecture

### Language Localization System

The app uses a custom localization system with:
- ARB (Application Resource Bundle) files for translations
- `LanguageProvider` for state management
- `AppLocalizations` for accessing strings throughout the app
- Support for dynamic language switching

### Provider Pattern

```dart
// In main.dart, wrap app with ChangeNotifierProvider
ChangeNotifierProvider(
  create: (_) => LanguageProvider(),
  child: const MyApp(),
)

// In widgets, access language with
final localizations = AppLocalizations.of(context);
```

### State Management Flow

```
User taps language button
         ↓
InkWell onTap calls toggleLanguage()
         ↓
LanguageProvider.toggleLanguage() changes locale
         ↓
LanguageProvider.notifyListeners() called
         ↓
Consumer<LanguageProvider> widget rebuilds
         ↓
MaterialApp updates its locale property
         ↓
AppLocalizations.of(context) returns new strings
         ↓
UI displays in new language
```

## Localization

### Adding New Strings

1. **Add to app_en.arb**
```json
{
  "myNewString": "Hello, World!"
}
```

2. **Add to app_ar.arb**
```json
{
  "myNewString": "مرحبا بالعالم"
}
```

3. **Add to AppLocalizations abstract class**
```dart
String get myNewString;
```

4. **Implement in implementations**
```dart
@override
String get myNewString => 'Hello, World!';  // English
String get myNewString => 'مرحبا بالعالم';  // Arabic
```

5. **Use in widgets**
```dart
final localizations = AppLocalizations.of(context);
Text(localizations.myNewString)
```

## Testing Strategy

### Unit Tests
- Test business logic in isolation
- Fast execution (milliseconds)
- 60% of tests should be unit tests

Example:
```dart
test('Should toggle language from English to Arabic', () {
  final provider = LanguageProvider();
  provider.toggleLanguage();
  expect(provider.locale.languageCode, equals('ar'));
});
```

### Widget Tests
- Test UI components and interactions
- Verify renders and user interactions
- 30% of tests should be widget tests

Example:
```dart
testWidgets('Tapping language button should toggle language', 
  (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('العربية'));
    await tester.pump();
    expect(find.text('اكتشف'), findsOneWidget);
  });
```

### Integration Tests
- Test complete user journeys
- Verify app behavior end-to-end
- 10% of tests should be integration tests

Example:
```dart
testWidgets('User toggles language and navigates',
  (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    await tester.tap(find.text('العربية'));
    await tester.pumpAndSettle();
    expect(find.text('اكتشف'), findsOneWidget);
  });
```

## Educational Resources

### For Students
- **[TEST_DOCUMENTATION.md](TEST_DOCUMENTATION.md)** - Comprehensive guide to testing in Flutter
  - Testing pyramid concept
  - ARRANGE-ACT-ASSERT pattern
  - Best practices and common pitfalls
  
- **[STUDENT_CHALLENGES.md](STUDENT_CHALLENGES.md)** - Three progressive challenges
  - Challenge 1: Understanding existing tests
  - Challenge 2: Identifying and fixing bugs
  - Challenge 3: Designing new tests
  - Includes expected answers for teachers

## Dependencies

- **flutter_localizations**: Flutter's localization framework
- **intl**: Internationalization library
- **provider**: State management
- **sensors_plus**: Device sensors (for tilt effect on detail page)
- **integration_test**: Integration testing framework

## Configuration

### Android Gradle Updates
The project uses:
- Kotlin Gradle Plugin: 2.3.0
- Android Gradle Plugin: 8.2.2

### Supported Locales
- English (en)
- Arabic (ar)

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Best Practices Implemented

✅ Proper state management with Provider  
✅ Comprehensive test coverage  
✅ Clean code architecture  
✅ Localization best practices  
✅ UI/UX considerations  
✅ Performance optimizations  
✅ Error handling  
✅ Code organization  

## Future Enhancements

- [ ] Save language preference to local storage
- [ ] Add more languages
- [ ] Database integration for landmarks
- [ ] Map integration
- [ ] User authentication
- [ ] Favorites system
- [ ] Offline support
- [ ] Push notifications

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Created as an educational project to demonstrate Flutter best practices, localization, state management, and comprehensive testing.

## Acknowledgments

- Flutter team for excellent documentation
- Provider package maintainers
- Testing best practices from the Flutter community

---

## Quick Start Commands

```bash
# Clone and setup
git clone https://github.com/yourusername/discover-dxb.git
cd discover-dxb
flutter pub get

# Run app
flutter run

# Run all tests
flutter test

# Run specific test type
flutter test test/unit/          # Unit tests
flutter test test/widget/        # Widget tests
flutter test integration_test/   # Integration tests

# Generate coverage
flutter test --coverage

# Clean build
flutter clean
flutter pub get
flutter run
```

For more information, questions, or contributions, please open an issue or contact the maintainer.
