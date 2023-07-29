import 'package:dartz/dartz.dart';
import 'package:peanut_app/features/auth/data/data_sources/i_auth_data_source.dart';
import 'package:peanut_app/features/auth/domain/entities/login_entity.dart';
import 'package:peanut_app/features/auth/domain/repository/i_auth_repository.dart';
import 'package:peanut_app/core/error/exceptions.dart';
import 'package:peanut_app/core/error/failure.dart';

class AuthRepository extends IAuthRepository {
  final IAuthDataSource authDataSource;

  AuthRepository({
    required this.authDataSource,
  });

  @override
  Future<Either<Failure, LoginEntity>> login({
    required int userId,
    required String password,
  }) async {
    try {
      LoginEntity result = await authDataSource.login(
        userId: userId,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.errorMessage, code: e.code));
    }
  }
}
