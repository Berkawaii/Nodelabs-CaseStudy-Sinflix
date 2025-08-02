import 'package:flutter_test/flutter_test.dart';
import 'package:sinflix/features/auth/presentation/bloc/auth_event.dart';

void main() {
  group('AuthEvent Tests', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testName = 'Test User';

    group('LoginRequested', () {
      test('should create LoginRequested event with email and password', () {
        const event = LoginRequested(email: testEmail, password: testPassword);
        
        expect(event, isA<AuthEvent>());
        expect(event.email, testEmail);
        expect(event.password, testPassword);
        expect(event.props, [testEmail, testPassword]);
      });

      test('should support value equality', () {
        const event1 = LoginRequested(email: testEmail, password: testPassword);
        const event2 = LoginRequested(email: testEmail, password: testPassword);
        
        expect(event1, equals(event2));
      });

      test('should not be equal when emails differ', () {
        const event1 = LoginRequested(email: 'email1@example.com', password: testPassword);
        const event2 = LoginRequested(email: 'email2@example.com', password: testPassword);
        
        expect(event1, isNot(equals(event2)));
      });

      test('should not be equal when passwords differ', () {
        const event1 = LoginRequested(email: testEmail, password: 'password1');
        const event2 = LoginRequested(email: testEmail, password: 'password2');
        
        expect(event1, isNot(equals(event2)));
      });

      test('should handle empty email and password', () {
        const event = LoginRequested(email: '', password: '');
        
        expect(event.email, '');
        expect(event.password, '');
        expect(event.props, ['', '']);
      });
    });

    group('RegisterRequested', () {
      test('should create RegisterRequested event with name, email and password', () {
        const event = RegisterRequested(
          name: testName,
          email: testEmail,
          password: testPassword,
        );
        
        expect(event, isA<AuthEvent>());
        expect(event.name, testName);
        expect(event.email, testEmail);
        expect(event.password, testPassword);
        expect(event.props, [testEmail, testPassword, testName]);
      });

      test('should support value equality', () {
        const event1 = RegisterRequested(
          name: testName,
          email: testEmail,
          password: testPassword,
        );
        const event2 = RegisterRequested(
          name: testName,
          email: testEmail,
          password: testPassword,
        );
        
        expect(event1, equals(event2));
      });

      test('should not be equal when names differ', () {
        const event1 = RegisterRequested(
          name: 'Name 1',
          email: testEmail,
          password: testPassword,
        );
        const event2 = RegisterRequested(
          name: 'Name 2',
          email: testEmail,
          password: testPassword,
        );
        
        expect(event1, isNot(equals(event2)));
      });

      test('should not be equal when emails differ', () {
        const event1 = RegisterRequested(
          name: testName,
          email: 'email1@example.com',
          password: testPassword,
        );
        const event2 = RegisterRequested(
          name: testName,
          email: 'email2@example.com',
          password: testPassword,
        );
        
        expect(event1, isNot(equals(event2)));
      });

      test('should not be equal when passwords differ', () {
        const event1 = RegisterRequested(
          name: testName,
          email: testEmail,
          password: 'password1',
        );
        const event2 = RegisterRequested(
          name: testName,
          email: testEmail,
          password: 'password2',
        );
        
        expect(event1, isNot(equals(event2)));
      });

      test('should handle empty fields', () {
        const event = RegisterRequested(
          name: '',
          email: '',
          password: '',
        );
        
        expect(event.name, '');
        expect(event.email, '');
        expect(event.password, '');
        expect(event.props, ['', '', '']);
      });
    });

    group('LogoutRequested', () {
      test('should create LogoutRequested event', () {
        const event = LogoutRequested();
        
        expect(event, isA<AuthEvent>());
        expect(event.props, isEmpty);
      });

      test('should support value equality', () {
        const event1 = LogoutRequested();
        const event2 = LogoutRequested();
        
        expect(event1, equals(event2));
      });
    });

    group('AuthStatusChecked', () {
      test('should create AuthStatusChecked event', () {
        const event = AuthStatusChecked();
        
        expect(event, isA<AuthEvent>());
        expect(event.props, isEmpty);
      });

      test('should support value equality', () {
        const event1 = AuthStatusChecked();
        const event2 = AuthStatusChecked();
        
        expect(event1, equals(event2));
      });
    });

    group('Event Comparisons', () {
      test('different auth events should not be equal', () {
        const loginEvent = LoginRequested(email: testEmail, password: testPassword);
        const registerEvent = RegisterRequested(
          name: testName,
          email: testEmail,
          password: testPassword,
        );
        const logoutEvent = LogoutRequested();
        const statusEvent = AuthStatusChecked();

        expect(loginEvent, isNot(equals(registerEvent)));
        expect(loginEvent, isNot(equals(logoutEvent)));
        expect(loginEvent, isNot(equals(statusEvent)));

        expect(registerEvent, isNot(equals(logoutEvent)));
        expect(registerEvent, isNot(equals(statusEvent)));

        expect(logoutEvent, isNot(equals(statusEvent)));
      });

      test('LoginRequested and RegisterRequested with same email/password should not be equal', () {
        const loginEvent = LoginRequested(email: testEmail, password: testPassword);
        const registerEvent = RegisterRequested(
          name: testName,
          email: testEmail,
          password: testPassword,
        );
        
        expect(loginEvent, isNot(equals(registerEvent)));
      });
    });

    group('Input Validation', () {
      test('should handle special characters in email', () {
        const specialEmail = 'test+special@example.com';
        const event = LoginRequested(email: specialEmail, password: testPassword);
        
        expect(event.email, specialEmail);
        expect(event.props, [specialEmail, testPassword]);
      });

      test('should handle special characters in password', () {
        const specialPassword = 'P@ssw0rd!123';
        const event = LoginRequested(email: testEmail, password: specialPassword);
        
        expect(event.password, specialPassword);
        expect(event.props, [testEmail, specialPassword]);
      });

      test('should handle long names', () {
        const longName = 'This is a very long name that might be entered by a user';
        const event = RegisterRequested(
          name: longName,
          email: testEmail,
          password: testPassword,
        );
        
        expect(event.name, longName);
        expect(event.props, [testEmail, testPassword, longName]);
      });

      test('should handle unicode characters in name', () {
        const unicodeName = 'José María González';
        const event = RegisterRequested(
          name: unicodeName,
          email: testEmail,
          password: testPassword,
        );
        
        expect(event.name, unicodeName);
        expect(event.props, [testEmail, testPassword, unicodeName]);
      });
    });
  });
}
