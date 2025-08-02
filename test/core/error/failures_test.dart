import 'package:flutter_test/flutter_test.dart';
import 'package:sinflix/core/error/failures.dart';

void main() {
  group('Failure Classes Tests', () {
    const testMessage = 'Test error message';

    group('ServerFailure', () {
      test('should create ServerFailure with correct message', () {
        const failure = ServerFailure(testMessage);
        
        expect(failure.message, testMessage);
        expect(failure, isA<Failure>());
      });

      test('should support value equality', () {
        const failure1 = ServerFailure(testMessage);
        const failure2 = ServerFailure(testMessage);
        
        expect(failure1, equals(failure2));
      });

      test('should not be equal when messages differ', () {
        const failure1 = ServerFailure('Message 1');
        const failure2 = ServerFailure('Message 2');
        
        expect(failure1, isNot(equals(failure2)));
      });

      test('should include message in props', () {
        const failure = ServerFailure(testMessage);
        
        expect(failure.props, contains(testMessage));
      });
    });

    group('ConnectionFailure', () {
      test('should create ConnectionFailure with correct message', () {
        const failure = ConnectionFailure(testMessage);
        
        expect(failure.message, testMessage);
        expect(failure, isA<Failure>());
      });

      test('should support value equality', () {
        const failure1 = ConnectionFailure(testMessage);
        const failure2 = ConnectionFailure(testMessage);
        
        expect(failure1, equals(failure2));
      });
    });

    group('DatabaseFailure', () {
      test('should create DatabaseFailure with correct message', () {
        const failure = DatabaseFailure(testMessage);
        
        expect(failure.message, testMessage);
        expect(failure, isA<Failure>());
      });

      test('should support value equality', () {
        const failure1 = DatabaseFailure(testMessage);
        const failure2 = DatabaseFailure(testMessage);
        
        expect(failure1, equals(failure2));
      });
    });

    group('CacheFailure', () {
      test('should create CacheFailure with correct message', () {
        const failure = CacheFailure(testMessage);
        
        expect(failure.message, testMessage);
        expect(failure, isA<Failure>());
      });

      test('should support value equality', () {
        const failure1 = CacheFailure(testMessage);
        const failure2 = CacheFailure(testMessage);
        
        expect(failure1, equals(failure2));
      });
    });

    group('ValidationFailure', () {
      test('should create ValidationFailure with correct message', () {
        const failure = ValidationFailure(testMessage);
        
        expect(failure.message, testMessage);
        expect(failure, isA<Failure>());
      });

      test('should support value equality', () {
        const failure1 = ValidationFailure(testMessage);
        const failure2 = ValidationFailure(testMessage);
        
        expect(failure1, equals(failure2));
      });
    });

    group('AuthFailure', () {
      test('should create AuthFailure with correct message', () {
        const failure = AuthFailure(testMessage);
        
        expect(failure.message, testMessage);
        expect(failure, isA<Failure>());
      });

      test('should support value equality', () {
        const failure1 = AuthFailure(testMessage);
        const failure2 = AuthFailure(testMessage);
        
        expect(failure1, equals(failure2));
      });

      test('should not be equal to other failure types with same message', () {
        const authFailure = AuthFailure(testMessage);
        const serverFailure = ServerFailure(testMessage);
        
        expect(authFailure, isNot(equals(serverFailure)));
      });
    });

    group('Failure Base Class', () {
      test('different failure types should not be equal', () {
        const serverFailure = ServerFailure(testMessage);
        const connectionFailure = ConnectionFailure(testMessage);
        const databaseFailure = DatabaseFailure(testMessage);
        const cacheFailure = CacheFailure(testMessage);
        const validationFailure = ValidationFailure(testMessage);
        const authFailure = AuthFailure(testMessage);

        expect(serverFailure, isNot(equals(connectionFailure)));
        expect(serverFailure, isNot(equals(databaseFailure)));
        expect(serverFailure, isNot(equals(cacheFailure)));
        expect(serverFailure, isNot(equals(validationFailure)));
        expect(serverFailure, isNot(equals(authFailure)));
        
        expect(connectionFailure, isNot(equals(databaseFailure)));
        expect(connectionFailure, isNot(equals(authFailure)));
        
        expect(databaseFailure, isNot(equals(validationFailure)));
        expect(validationFailure, isNot(equals(authFailure)));
      });
    });

    group('Error Messages', () {
      test('should handle empty message', () {
        const failure = ServerFailure('');
        
        expect(failure.message, '');
        expect(failure.props, contains(''));
      });

      test('should handle long error messages', () {
        const longMessage = 'This is a very long error message that might be returned from an API or database operation and should be handled properly by the failure classes';
        const failure = ServerFailure(longMessage);
        
        expect(failure.message, longMessage);
        expect(failure.props, contains(longMessage));
      });

      test('should handle special characters in message', () {
        const specialMessage = 'Error: {"status": 500, "message": "Internal Server Error", "details": "Something went wrong!"}';
        const failure = ServerFailure(specialMessage);
        
        expect(failure.message, specialMessage);
        expect(failure.props, contains(specialMessage));
      });
    });
  });
}
