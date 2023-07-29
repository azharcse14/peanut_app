import 'package:dartz/dartz.dart';
import 'package:peanut_app/core/error/failure.dart';

abstract class IPhoneNumberRepository {

  Future<Either<Failure, String>> getPhoneNumber();

}