import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getMovies({required int page});
  Future<Either<Failure, bool>> toggleFavorite({required String movieId});
}
