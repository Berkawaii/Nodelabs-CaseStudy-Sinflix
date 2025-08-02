import 'package:flutter_test/flutter_test.dart';
import 'package:sinflix/features/auth/domain/entities/user.dart';

void main() {
  group('User Entity Tests', () {
    const testUser = User(
      id: '1',
      name: 'Test User',
      email: 'test@example.com',
      token: 'test_token',
      photoUrl: 'https://example.com/photo.jpg',
    );

    test('should create User instance with correct properties', () {
      expect(testUser.id, '1');
      expect(testUser.name, 'Test User');
      expect(testUser.email, 'test@example.com');
      expect(testUser.token, 'test_token');
      expect(testUser.photoUrl, 'https://example.com/photo.jpg');
    });

    test('should support value equality', () {
      const user1 = User(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        token: 'test_token',
      );

      const user2 = User(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        token: 'test_token',
      );

      expect(user1, equals(user2));
    });

    test('should not be equal when properties differ', () {
      const user1 = User(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        token: 'test_token',
      );

      const user2 = User(
        id: '2',
        name: 'Test User',
        email: 'test@example.com',
        token: 'test_token',
      );

      expect(user1, isNot(equals(user2)));
    });

    test('should handle null photoUrl', () {
      const userWithoutPhoto = User(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        token: 'test_token',
      );

      expect(userWithoutPhoto.photoUrl, isNull);
      expect(userWithoutPhoto.id, '1');
      expect(userWithoutPhoto.name, 'Test User');
    });

    test('should include all properties in props for equality', () {
      const user = User(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        token: 'test_token',
        photoUrl: 'photo.jpg',
      );

      expect(user.props, contains('1'));
      expect(user.props, contains('Test User'));
      expect(user.props, contains('test@example.com'));
      expect(user.props, contains('test_token'));
      expect(user.props, contains('photo.jpg'));
    });
  });
}
