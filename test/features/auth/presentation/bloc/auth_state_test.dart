import 'package:flutter_test/flutter_test.dart';
import 'package:sinflix/features/auth/domain/entities/user.dart';
import 'package:sinflix/features/auth/presentation/bloc/auth_state.dart';

void main() {
  group('AuthState Tests', () {
    const testUser = User(
      id: '1',
      name: 'Test User',
      email: 'test@example.com',
      token: 'test_token',
    );

    group('AuthInitial', () {
      test('should create AuthInitial state', () {
        const state = AuthInitial();
        
        expect(state, isA<AuthState>());
        expect(state.props, isEmpty);
      });

      test('should support value equality', () {
        const state1 = AuthInitial();
        const state2 = AuthInitial();
        
        expect(state1, equals(state2));
      });
    });

    group('AuthLoading', () {
      test('should create AuthLoading state', () {
        const state = AuthLoading();
        
        expect(state, isA<AuthState>());
        expect(state.props, isEmpty);
      });

      test('should support value equality', () {
        const state1 = AuthLoading();
        const state2 = AuthLoading();
        
        expect(state1, equals(state2));
      });
    });

    group('AuthAuthenticated', () {
      test('should create AuthAuthenticated state with user', () {
        const state = AuthAuthenticated(testUser);
        
        expect(state, isA<AuthState>());
        expect(state.user, testUser);
        expect(state.props, [testUser]);
      });

      test('should support value equality', () {
        const state1 = AuthAuthenticated(testUser);
        const state2 = AuthAuthenticated(testUser);
        
        expect(state1, equals(state2));
      });

      test('should not be equal when users differ', () {
        const user2 = User(
          id: '2',
          name: 'Different User',
          email: 'different@example.com',
          token: 'different_token',
        );
        
        const state1 = AuthAuthenticated(testUser);
        const state2 = AuthAuthenticated(user2);
        
        expect(state1, isNot(equals(state2)));
      });
    });

    group('AuthSuccess', () {
      test('should create AuthSuccess state with user', () {
        const state = AuthSuccess(testUser);
        
        expect(state, isA<AuthState>());
        expect(state.user, testUser);
        expect(state.props, [testUser]);
      });

      test('should support value equality', () {
        const state1 = AuthSuccess(testUser);
        const state2 = AuthSuccess(testUser);
        
        expect(state1, equals(state2));
      });

      test('should not be equal when users differ', () {
        const user2 = User(
          id: '2',
          name: 'Different User',
          email: 'different@example.com',
          token: 'different_token',
        );
        
        const state1 = AuthSuccess(testUser);
        const state2 = AuthSuccess(user2);
        
        expect(state1, isNot(equals(state2)));
      });
    });

    group('AuthUnauthenticated', () {
      test('should create AuthUnauthenticated state', () {
        const state = AuthUnauthenticated();
        
        expect(state, isA<AuthState>());
        expect(state.props, isEmpty);
      });

      test('should support value equality', () {
        const state1 = AuthUnauthenticated();
        const state2 = AuthUnauthenticated();
        
        expect(state1, equals(state2));
      });
    });

    group('AuthError', () {
      const testMessage = 'Test error message';

      test('should create AuthError state with message', () {
        const state = AuthError(testMessage);
        
        expect(state, isA<AuthState>());
        expect(state.message, testMessage);
        expect(state.props, [testMessage]);
      });

      test('should support value equality', () {
        const state1 = AuthError(testMessage);
        const state2 = AuthError(testMessage);
        
        expect(state1, equals(state2));
      });

      test('should not be equal when messages differ', () {
        const state1 = AuthError('Error 1');
        const state2 = AuthError('Error 2');
        
        expect(state1, isNot(equals(state2)));
      });

      test('should handle empty error message', () {
        const state = AuthError('');
        
        expect(state.message, '');
        expect(state.props, ['']);
      });

      test('should handle long error messages', () {
        const longMessage = 'This is a very long error message that should be handled properly';
        const state = AuthError(longMessage);
        
        expect(state.message, longMessage);
        expect(state.props, [longMessage]);
      });
    });

    group('State Comparisons', () {
      test('different auth states should not be equal', () {
        const initial = AuthInitial();
        const loading = AuthLoading();
        const authenticated = AuthAuthenticated(testUser);
        const success = AuthSuccess(testUser);
        const unauthenticated = AuthUnauthenticated();
        const error = AuthError('Error');

        expect(initial, isNot(equals(loading)));
        expect(initial, isNot(equals(authenticated)));
        expect(initial, isNot(equals(success)));
        expect(initial, isNot(equals(unauthenticated)));
        expect(initial, isNot(equals(error)));

        expect(loading, isNot(equals(authenticated)));
        expect(loading, isNot(equals(unauthenticated)));
        expect(loading, isNot(equals(error)));

        expect(authenticated, isNot(equals(success)));
        expect(authenticated, isNot(equals(unauthenticated)));
        expect(authenticated, isNot(equals(error)));

        expect(success, isNot(equals(unauthenticated)));
        expect(success, isNot(equals(error)));

        expect(unauthenticated, isNot(equals(error)));
      });

      test('AuthAuthenticated and AuthSuccess should be different even with same user', () {
        const authenticated = AuthAuthenticated(testUser);
        const success = AuthSuccess(testUser);
        
        expect(authenticated, isNot(equals(success)));
      });
    });
  });
}
