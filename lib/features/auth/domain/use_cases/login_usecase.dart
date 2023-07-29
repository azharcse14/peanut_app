import 'package:dartz/dartz.dart';
import 'package:peanut_app/features/auth/domain/repository/i_auth_repository.dart';
import 'package:peanut_app/core/error/failure.dart';

import '../entities/login_entity.dart';


class LoginUseCase {
  IAuthRepository authRepository;
  LoginUseCase({required this.authRepository});

  Future<Either<Failure, LoginEntity>> call({
    required int userId,
    required String password,
  }) async =>
      await authRepository.login(
        userId: userId,
        password: password,
      );
}
