// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Basic App Tests', () {
    testWidgets('MaterialApp should render without errors', (WidgetTester tester) async {
      // Simple test to verify basic Flutter setup works
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: null,
            body: Center(
              child: Text('Sinflix Test App'),
            ),
          ),
        ),
      );

      // Verify the test app loads
      expect(find.text('Sinflix Test App'), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('App should handle basic navigation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const HomePage(),
          routes: {
            '/second': (context) => const SecondPage(),
          },
        ),
      );

      // Verify home page
      expect(find.text('Home Page'), findsOneWidget);

      // Tap navigation button
      await tester.tap(find.text('Go to Second Page'));
      await tester.pumpAndSettle();

      // Verify navigation
      expect(find.text('Second Page'), findsOneWidget);
    });

    testWidgets('App should handle state changes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CounterPage(),
        ),
      );

      // Verify initial state
      expect(find.text('Count: 0'), findsOneWidget);

      // Tap increment button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify state change
      expect(find.text('Count: 1'), findsOneWidget);
    });
  });
}

// Test pages for demonstration
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/second'),
              child: const Text('Go to Second Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second')),
      body: const Center(
        child: Text('Second Page'),
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Text('Count: $count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => count++),
        child: const Icon(Icons.add),
      ),
    );
  }
}
