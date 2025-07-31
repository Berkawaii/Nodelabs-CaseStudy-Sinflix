import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<Either<Failure, User>> call(String name, String email, String password) async {
    return await _authRepository.register(name, email, password);
  }
}
