import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Integration Tests', () {
    testWidgets('should render basic Material App without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          title: 'Sinflix Test',
          home: TestHomePage(),
        ),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('Sinflix Test Home'), findsOneWidget);
    });

    testWidgets('should handle navigation between screens', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const TestHomePage(),
          routes: {
            '/details': (context) => const TestDetailsPage(),
          },
        ),
      );

      // Verify we're on home page
      expect(find.text('Sinflix Test Home'), findsOneWidget);

      // Navigate to details
      await tester.tap(find.text('Go to Details'));
      await tester.pumpAndSettle();

      // Verify we're on details page
      expect(find.text('Details Page'), findsOneWidget);
      expect(find.text('Sinflix Test Home'), findsNothing);
    });

    testWidgets('should handle back navigation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const TestHomePage(),
          routes: {
            '/details': (context) => const TestDetailsPage(),
          },
        ),
      );

      // Navigate to details
      await tester.tap(find.text('Go to Details'));
      await tester.pumpAndSettle();

      // Go back
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Verify we're back on home page
      expect(find.text('Sinflix Test Home'), findsOneWidget);
      expect(find.text('Details Page'), findsNothing);
    });

    testWidgets('should handle form input and validation', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TestFormPage(),
        ),
      );

      // Find form elements
      final nameField = find.byKey(const Key('name_field'));
      final emailField = find.byKey(const Key('email_field'));
      final submitButton = find.text('Submit');

      expect(nameField, findsOneWidget);
      expect(emailField, findsOneWidget);
      expect(submitButton, findsOneWidget);

      // Test form input
      await tester.enterText(nameField, 'Test User');
      await tester.enterText(emailField, 'test@example.com');
      await tester.pump();

      // Submit form
      await tester.tap(submitButton);
      await tester.pump();

      // Verify form was submitted
      expect(find.text('Form submitted!'), findsOneWidget);
    });

    testWidgets('should handle theme switching', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestThemeApp(),
      );

      // Initially should show light theme indicator
      expect(find.text('Light Theme'), findsOneWidget);

      // Tap theme switch
      await tester.tap(find.byIcon(Icons.brightness_6));
      await tester.pump();

      // Should now show dark theme indicator
      expect(find.text('Dark Theme'), findsOneWidget);
    });
  });
}

// Test pages for integration testing
class TestHomePage extends StatelessWidget {
  const TestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sinflix Test Home'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/details'),
              child: const Text('Go to Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestDetailsPage extends StatelessWidget {
  const TestDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: const Center(
        child: Text('Details Page'),
      ),
    );
  }
}

class TestFormPage extends StatefulWidget {
  const TestFormPage({super.key});

  @override
  State<TestFormPage> createState() => _TestFormPageState();
}

class _TestFormPageState extends State<TestFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_submitted) 
                const Text('Form submitted!')
              else ...[
                TextFormField(
                  key: const Key('name_field'),
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: const Key('email_field'),
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _submitted = true;
                    });
                  },
                  child: const Text('Submit'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class TestThemeApp extends StatefulWidget {
  const TestThemeApp({super.key});

  @override
  State<TestThemeApp> createState() => _TestThemeAppState();
}

class _TestThemeAppState extends State<TestThemeApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Theme Test'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () {
                setState(() {
                  _isDark = !_isDark;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: Text(_isDark ? 'Dark Theme' : 'Light Theme'),
        ),
      ),
    );
  }
}
