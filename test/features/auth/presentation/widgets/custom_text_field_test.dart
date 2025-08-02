import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sinflix/features/auth/presentation/widgets/custom_text_field.dart';

void main() {
  group('CustomTextField Widget Tests', () {
    testWidgets('should render with basic properties', (WidgetTester tester) async {
      final controller = TextEditingController();
      const label = 'Enter text';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              label: label,
            ),
          ),
        ),
      );

      // Verify that label text is displayed
      expect(find.text(label), findsOneWidget);
      
      // Verify that a text field is rendered
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('should handle text input', (WidgetTester tester) async {
      final controller = TextEditingController();
      const testText = 'Test input text';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              label: 'Enter text',
            ),
          ),
        ),
      );

      // Find the text field and enter text
      final textField = find.byType(TextFormField);
      await tester.enterText(textField, testText);
      await tester.pump();

      // Verify that the text was entered through controller
      expect(controller.text, testText);
    });

    testWidgets('should handle password field with obscured text', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              label: 'Password',
              obscureText: true,
            ),
          ),
        ),
      );

      // Verify the widget renders with obscureText property
      expect(find.byType(CustomTextField), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('should display prefix icon when provided', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              label: 'Email',
              prefixIcon: Icons.email,
            ),
          ),
        ),
      );

      // Verify prefix icon is displayed
      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('should display suffix icon when provided', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              label: 'Search',
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
      );

      // Verify suffix icon is displayed
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should call validator when validation occurs', (WidgetTester tester) async {
      final controller = TextEditingController();
      bool validatorCalled = false;
      
      // Create a new form with a key to test validation
      final formState = GlobalKey<FormState>();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formState,
              child: CustomTextField(
                controller: controller,
                label: 'Test',
                validator: (value) {
                  validatorCalled = true;
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      // Trigger validation
      formState.currentState?.validate();
      await tester.pump();

      expect(validatorCalled, true);
    });

    testWidgets('should handle different keyboard types', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
      );

      // Verify the widget renders with keyboard type set
      expect(find.byType(CustomTextField), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('should handle controller with initial text', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Initial text');
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              label: 'Test',
            ),
          ),
        ),
      );

      // Verify initial text from controller is displayed
      expect(find.text('Initial text'), findsOneWidget);

      // Verify controller is connected
      final textFieldWidget = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textFieldWidget.controller, controller);
    });

    testWidgets('should apply custom styling and theme', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              label: 'Styled field',
            ),
          ),
        ),
      );

      // Verify the widget renders without errors with styling
      expect(find.byType(CustomTextField), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('should handle dark theme', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              label: 'Dark theme field',
            ),
          ),
        ),
      );

      // Verify the widget renders properly in dark theme
      expect(find.byType(CustomTextField), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('should handle focus changes', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              label: 'Test',
            ),
          ),
        ),
      );

      // Tap the field to focus
      await tester.tap(find.byType(TextFormField));
      await tester.pump();

      // Verify field can receive focus (no errors thrown)
      expect(find.byType(CustomTextField), findsOneWidget);
    });

    testWidgets('should render with all optional parameters', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              label: 'Complete field',
              keyboardType: TextInputType.text,
              obscureText: false,
              prefixIcon: Icons.person,
              suffixIcon: const Icon(Icons.clear),
              validator: (value) => value?.isEmpty == true ? 'Required' : null,
            ),
          ),
        ),
      );

      // Verify all elements are rendered
      expect(find.byType(CustomTextField), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsOneWidget);
      expect(find.text('Complete field'), findsOneWidget);
    });
  });
}
