import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_api_service.dart';
import '../models/movie_model.dart';

@Injectable(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService apiService;

  MovieRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<Movie>>> getMovies({required int page}) async {
    try {
      final response = await apiService.getMovies(page: page);

      // Parse the response - response.data contains MovieListResponse
      final movies = response.data.movies.map((movieModel) => movieModel.toEntity()).toList();

      return Right(movies);
    } catch (e) {
      AppLogger.instance.error('Error fetching movies: $e');
      return Left(ServerFailure('Network error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite({required String movieId}) async {
    try {
      await apiService.toggleFavorite(favoriteId: movieId);
      // API call successful, return true (we'll update UI optimistically)
      return const Right(true);
    } catch (e) {
      AppLogger.instance.error('Error toggling favorite: $e');
      return Left(ServerFailure('Network error: ${e.toString()}'));
    }
  }
}
