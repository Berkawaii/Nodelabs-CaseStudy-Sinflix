import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/movie_repository.dart';

@injectable
class ToggleFavoriteUseCase implements UseCase<bool, ToggleFavoriteParams> {
  final MovieRepository repository;

  ToggleFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(ToggleFavoriteParams params) async {
    return await repository.toggleFavorite(movieId: params.movieId);
  }
}

class ToggleFavoriteParams {
  final String movieId;

  ToggleFavoriteParams({required this.movieId});
}
