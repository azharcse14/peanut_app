import 'package:dartz/dartz.dart';
import 'package:peanut_app/features/auth/domain/entities/login_entity.dart';
import 'package:peanut_app/core/error/failure.dart';

abstract class IAuthRepository {

  Future<Either<Failure, LoginEntity>> login({
    required int userId,
    required String password,
  });

}
