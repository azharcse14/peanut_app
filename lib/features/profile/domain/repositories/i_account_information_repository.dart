import 'package:dartz/dartz.dart';
import 'package:peanut_app/core/error/failure.dart';
import 'package:peanut_app/features/profile/domain/entities/account_info_parent_entity.dart';

abstract class IAccountInformationRepository {

  Future<Either<Failure, AccountInfoParentEntity>> getAccountInformation();

}