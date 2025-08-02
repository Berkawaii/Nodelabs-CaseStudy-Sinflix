import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Auth Service Tests', () {
    late MockAuthService authService;

    setUp(() {
      authService = MockAuthService();
    });

    test('should validate email format correctly', () {
      // Valid emails
      expect(authService.isValidEmail('test@example.com'), true);
      expect(authService.isValidEmail('user.name@domain.co.uk'), true);
      expect(authService.isValidEmail('user123@example.org'), true);

      // Invalid emails
      expect(authService.isValidEmail(''), false);
      expect(authService.isValidEmail('invalid-email'), false);
      expect(authService.isValidEmail('@example.com'), false);
      expect(authService.isValidEmail('test@'), false);
      expect(authService.isValidEmail('test.example.com'), false);
    });

    test('should validate password strength correctly', () {
      // Valid passwords
      expect(authService.isStrongPassword('Password123!'), true);
      expect(authService.isStrongPassword('MySecure1@'), true);
      expect(authService.isStrongPassword('Complex#99'), true);

      // Invalid passwords
      expect(authService.isStrongPassword(''), false);
      expect(authService.isStrongPassword('12345'), false);
      expect(authService.isStrongPassword('password'), false);
      expect(authService.isStrongPassword('PASSWORD'), false);
      expect(authService.isStrongPassword('Pass1'), false); // Too short
      expect(authService.isStrongPassword('password123'), false); // No uppercase
      expect(authService.isStrongPassword('PASSWORD123'), false); // No lowercase
      expect(authService.isStrongPassword('Password'), false); // No numbers
    });

    test('should handle login attempts correctly', () async {
      // Successful login
      final result1 = await authService.login('test@example.com', 'Password123!');
      expect(result1.isSuccess, true);
      expect(result1.user?.email, 'test@example.com');

      // Failed login - invalid email
      final result2 = await authService.login('invalid-email', 'Password123!');
      expect(result2.isSuccess, false);
      expect(result2.errorMessage, contains('email'));

      // Failed login - weak password
      final result3 = await authService.login('test@example.com', '123');
      expect(result3.isSuccess, false);
      expect(result3.errorMessage, contains('weak'));
    });

    test('should handle registration correctly', () async {
      // Successful registration
      final result1 = await authService.register(
        'John Doe',
        'john@example.com',
        'SecurePass1!',
      );
      expect(result1.isSuccess, true);
      expect(result1.user?.name, 'John Doe');
      expect(result1.user?.email, 'john@example.com');

      // Failed registration - existing email
      final result2 = await authService.register(
        'Jane Doe',
        'john@example.com', // Same email
        'AnotherPass1!',
      );
      expect(result2.isSuccess, false);
      expect(result2.errorMessage, contains('already exists'));
    });

    test('should handle logout correctly', () async {
      // Login first
      await authService.login('test@example.com', 'Password123!');
      expect(authService.currentUser, isNotNull);

      // Logout
      await authService.logout();
      expect(authService.currentUser, isNull);
    });

    test('should handle password reset correctly', () async {
      // Valid email
      final result1 = await authService.resetPassword('test@example.com');
      expect(result1.isSuccess, true);

      // Invalid email
      final result2 = await authService.resetPassword('invalid-email');
      expect(result2.isSuccess, false);
      expect(result2.errorMessage, contains('email'));
    });
  });

  group('Movie Service Tests', () {
    late MockMovieService movieService;

    setUp(() {
      movieService = MockMovieService();
    });

    test('should fetch popular movies correctly', () async {
      final movies = await movieService.getPopularMovies();
      expect(movies, isNotEmpty);
      expect(movies.length, greaterThan(0));
      expect(movies.first.title, isNotEmpty);
    });

    test('should search movies correctly', () async {
      // Search with valid query
      final results1 = await movieService.searchMovies('Inception');
      expect(results1, isNotEmpty);
      expect(results1.any((movie) => movie.title.contains('Inception')), true);

      // Search with empty query
      final results2 = await movieService.searchMovies('');
      expect(results2, isEmpty);

      // Search with no results
      final results3 = await movieService.searchMovies('NonExistentMovie12345');
      expect(results3, isEmpty);
    });

    test('should handle favorites correctly', () async {
      final movieId = 'test-movie-1';
      
      // Initially not favorite
      expect(await movieService.isFavorite(movieId), false);

      // Add to favorites
      await movieService.addToFavorites(movieId);
      expect(await movieService.isFavorite(movieId), true);

      // Remove from favorites
      await movieService.removeFromFavorites(movieId);
      expect(await movieService.isFavorite(movieId), false);
    });

    test('should get movie details correctly', () async {
      final movieId = 'test-movie-1';
      final movie = await movieService.getMovieDetails(movieId);
      
      expect(movie, isNotNull);
      expect(movie.id, movieId);
      expect(movie.title, isNotEmpty);
      expect(movie.overview, isNotEmpty);
    });

    test('should handle watchlist correctly', () async {
      final movieId = 'test-movie-1';
      
      // Initially not in watchlist
      expect(await movieService.isInWatchlist(movieId), false);

      // Add to watchlist
      await movieService.addToWatchlist(movieId);
      expect(await movieService.isInWatchlist(movieId), true);

      // Remove from watchlist
      await movieService.removeFromWatchlist(movieId);
      expect(await movieService.isInWatchlist(movieId), false);
    });
  });
}

// Mock Auth Service for testing
class MockAuthService {
  TestUser? currentUser;
  final List<TestUser> _registeredUsers = [];

  bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return emailRegex.hasMatch(email);
  }

  bool isStrongPassword(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    return true;
  }

  Future<AuthResult> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 100)); // Simulate network

    if (!isValidEmail(email)) {
      return AuthResult.failure('Invalid email format');
    }

    if (!isStrongPassword(password)) {
      return AuthResult.failure('Password is too weak');
    }

    currentUser = TestUser(
      id: 'user-123',
      name: 'Test User',
      email: email,
    );

    return AuthResult.success(currentUser!);
  }

  Future<AuthResult> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (!isValidEmail(email)) {
      return AuthResult.failure('Invalid email format');
    }

    if (!isStrongPassword(password)) {
      return AuthResult.failure('Password is too weak');
    }

    // Check if email already exists
    if (_registeredUsers.any((user) => user.email == email)) {
      return AuthResult.failure('Email already exists');
    }

    final user = TestUser(
      id: 'user-${_registeredUsers.length + 1}',
      name: name,
      email: email,
    );

    _registeredUsers.add(user);
    currentUser = user;

    return AuthResult.success(user);
  }

  Future<void> logout() async {
    currentUser = null;
  }

  Future<AuthResult> resetPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (!isValidEmail(email)) {
      return AuthResult.failure('Invalid email format');
    }

    return AuthResult.success(null);
  }
}

// Mock Movie Service for testing
class MockMovieService {
  final List<String> _favorites = [];
  final List<String> _watchlist = [];

  final List<TestMovie> _mockMovies = [
    TestMovie(
      id: 'test-movie-1',
      title: 'Inception',
      overview: 'A mind-bending thriller about dreams within dreams.',
      releaseDate: '2010-07-16',
      rating: 8.8,
    ),
    TestMovie(
      id: 'test-movie-2',
      title: 'The Dark Knight',
      overview: 'Batman faces the Joker in this epic superhero film.',
      releaseDate: '2008-07-18',
      rating: 9.0,
    ),
    TestMovie(
      id: 'test-movie-3',
      title: 'Interstellar',
      overview: 'A space odyssey about saving humanity.',
      releaseDate: '2014-11-07',
      rating: 8.6,
    ),
  ];

  Future<List<TestMovie>> getPopularMovies() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockMovies;
  }

  Future<List<TestMovie>> searchMovies(String query) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    if (query.isEmpty) return [];
    
    return _mockMovies
        .where((movie) => 
            movie.title.toLowerCase().contains(query.toLowerCase()) ||
            movie.overview.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<TestMovie> getMovieDetails(String movieId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockMovies.firstWhere((movie) => movie.id == movieId);
  }

  Future<void> addToFavorites(String movieId) async {
    if (!_favorites.contains(movieId)) {
      _favorites.add(movieId);
    }
  }

  Future<void> removeFromFavorites(String movieId) async {
    _favorites.remove(movieId);
  }

  Future<bool> isFavorite(String movieId) async {
    return _favorites.contains(movieId);
  }

  Future<void> addToWatchlist(String movieId) async {
    if (!_watchlist.contains(movieId)) {
      _watchlist.add(movieId);
    }
  }

  Future<void> removeFromWatchlist(String movieId) async {
    _watchlist.remove(movieId);
  }

  Future<bool> isInWatchlist(String movieId) async {
    return _watchlist.contains(movieId);
  }
}

// Test models
class TestUser {
  final String id;
  final String name;
  final String email;

  TestUser({
    required this.id,
    required this.name,
    required this.email,
  });
}

class TestMovie {
  final String id;
  final String title;
  final String overview;
  final String releaseDate;
  final double rating;

  TestMovie({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.rating,
  });
}

class AuthResult {
  final bool isSuccess;
  final TestUser? user;
  final String? errorMessage;

  AuthResult.success(this.user) 
      : isSuccess = true, 
        errorMessage = null;

  AuthResult.failure(this.errorMessage) 
      : isSuccess = false, 
        user = null;
}
