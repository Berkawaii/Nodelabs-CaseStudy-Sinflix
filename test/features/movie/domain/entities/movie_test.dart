import 'package:flutter_test/flutter_test.dart';
import 'package:sinflix/features/movie/domain/entities/movie.dart';

void main() {
  group('Movie Entity Tests', () {
    const testMovie = Movie(
      id: '1',
      title: 'Test Movie',
      year: '2024',
      rated: 'PG-13',
      released: '01 Jan 2024',
      runtime: '120 min',
      genre: 'Action, Drama',
      director: 'Test Director',
      writer: 'Test Writer',
      actors: 'Actor 1, Actor 2',
      plot: 'This is a test movie plot description.',
      language: 'English',
      country: 'USA',
      awards: 'Best Picture',
      poster: 'https://example.com/poster.jpg',
      metascore: '85',
      imdbRating: '8.5',
      imdbVotes: '100,000',
      imdbID: 'tt1234567',
      type: 'movie',
      images: ['image1.jpg', 'image2.jpg', 'image3.jpg'],
      comingSoon: false,
      isFavorite: false,
    );

    test('should create Movie instance with correct properties', () {
      expect(testMovie.id, '1');
      expect(testMovie.title, 'Test Movie');
      expect(testMovie.year, '2024');
      expect(testMovie.rated, 'PG-13');
      expect(testMovie.runtime, '120 min');
      expect(testMovie.genre, 'Action, Drama');
      expect(testMovie.director, 'Test Director');
      expect(testMovie.imdbRating, '8.5');
      expect(testMovie.isFavorite, false);
      expect(testMovie.comingSoon, false);
      expect(testMovie.images.length, 3);
    });

    test('should support value equality', () {
      const movie1 = Movie(
        id: '1',
        title: 'Test Movie',
        year: '2024',
        rated: 'PG-13',
        released: '01 Jan 2024',
        runtime: '120 min',
        genre: 'Action',
        director: 'Test Director',
        writer: 'Test Writer',
        actors: 'Test Actor',
        plot: 'Test plot',
        language: 'English',
        country: 'USA',
        awards: 'Test Awards',
        poster: 'test_poster.jpg',
        metascore: '80',
        imdbRating: '8.0',
        imdbVotes: '1000',
        imdbID: 'tt1234567',
        type: 'movie',
        images: ['image1.jpg'],
        comingSoon: false,
        isFavorite: false,
      );

      const movie2 = Movie(
        id: '1',
        title: 'Test Movie',
        year: '2024',
        rated: 'PG-13',
        released: '01 Jan 2024',
        runtime: '120 min',
        genre: 'Action',
        director: 'Test Director',
        writer: 'Test Writer',
        actors: 'Test Actor',
        plot: 'Test plot',
        language: 'English',
        country: 'USA',
        awards: 'Test Awards',
        poster: 'test_poster.jpg',
        metascore: '80',
        imdbRating: '8.0',
        imdbVotes: '1000',
        imdbID: 'tt1234567',
        type: 'movie',
        images: ['image1.jpg'],
        comingSoon: false,
        isFavorite: false,
      );

      expect(movie1, equals(movie2));
    });

    test('should not be equal when properties differ', () {
      const movie1 = Movie(
        id: '1',
        title: 'Test Movie 1',
        year: '2024',
        rated: 'PG-13',
        released: '01 Jan 2024',
        runtime: '120 min',
        genre: 'Action',
        director: 'Test Director',
        writer: 'Test Writer',
        actors: 'Test Actor',
        plot: 'Test plot',
        language: 'English',
        country: 'USA',
        awards: 'Test Awards',
        poster: 'test_poster.jpg',
        metascore: '80',
        imdbRating: '8.0',
        imdbVotes: '1000',
        imdbID: 'tt1234567',
        type: 'movie',
        images: ['image1.jpg'],
        comingSoon: false,
        isFavorite: false,
      );

      const movie2 = Movie(
        id: '1',
        title: 'Test Movie 2',
        year: '2024',
        rated: 'PG-13',
        released: '01 Jan 2024',
        runtime: '120 min',
        genre: 'Action',
        director: 'Test Director',
        writer: 'Test Writer',
        actors: 'Test Actor',
        plot: 'Test plot',
        language: 'English',
        country: 'USA',
        awards: 'Test Awards',
        poster: 'test_poster.jpg',
        metascore: '80',
        imdbRating: '8.0',
        imdbVotes: '1000',
        imdbID: 'tt1234567',
        type: 'movie',
        images: ['image1.jpg'],
        comingSoon: false,
        isFavorite: false,
      );

      expect(movie1, isNot(equals(movie2)));
    });

    test('should handle favorite status changes', () {
      const favoriteMovie = Movie(
        id: '1',
        title: 'Test Movie',
        year: '2024',
        rated: 'PG-13',
        released: '01 Jan 2024',
        runtime: '120 min',
        genre: 'Action',
        director: 'Test Director',
        writer: 'Test Writer',
        actors: 'Test Actor',
        plot: 'Test plot',
        language: 'English',
        country: 'USA',
        awards: 'Test Awards',
        poster: 'test_poster.jpg',
        metascore: '80',
        imdbRating: '8.0',
        imdbVotes: '1000',
        imdbID: 'tt1234567',
        type: 'movie',
        images: ['image1.jpg'],
        comingSoon: false,
        isFavorite: true,
      );

      expect(favoriteMovie.isFavorite, true);
    });

    test('should handle coming soon status', () {
      const comingSoonMovie = Movie(
        id: '1',
        title: 'Upcoming Movie',
        year: '2025',
        rated: 'PG-13',
        released: '01 Jan 2025',
        runtime: '130 min',
        genre: 'Sci-Fi',
        director: 'Future Director',
        writer: 'Future Writer',
        actors: 'Future Actor',
        plot: 'Future plot',
        language: 'English',
        country: 'USA',
        awards: 'TBD',
        poster: 'coming_soon.jpg',
        metascore: 'N/A',
        imdbRating: 'N/A',
        imdbVotes: '0',
        imdbID: 'tt7654321',
        type: 'movie',
        images: ['teaser.jpg'],
        comingSoon: true,
        isFavorite: false,
      );

      expect(comingSoonMovie.comingSoon, true);
      expect(comingSoonMovie.year, '2025');
      expect(comingSoonMovie.title, 'Upcoming Movie');
    });

    test('should handle multiple images', () {
      expect(testMovie.images, isA<List<String>>());
      expect(testMovie.images.length, 3);
      expect(testMovie.images, contains('image1.jpg'));
      expect(testMovie.images, contains('image2.jpg'));
      expect(testMovie.images, contains('image3.jpg'));
    });

    test('should include all properties in props for equality', () {
      expect(testMovie.props, contains('1'));
      expect(testMovie.props, contains('Test Movie'));
      expect(testMovie.props, contains('2024'));
      expect(testMovie.props, contains('PG-13'));
      expect(testMovie.props, contains(false)); // isFavorite
      expect(testMovie.props, contains(false)); // comingSoon
      // Images list'in props içinde olduğunu kontrol et
      expect(testMovie.props.length, greaterThan(0));
      final imagesList = testMovie.props.firstWhere(
        (prop) => prop is List<String>,
        orElse: () => <String>[],
      );
      expect(imagesList, isA<List<String>>());
      expect((imagesList as List<String>), contains('image1.jpg'));
    });
  });
}
