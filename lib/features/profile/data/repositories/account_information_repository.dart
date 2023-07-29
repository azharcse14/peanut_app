import 'package:dartz/dartz.dart';
import 'package:peanut_app/core/error/exceptions.dart';
import 'package:peanut_app/core/error/failure.dart';
import 'package:peanut_app/features/profile/data/data_sources/account_information/i_account_information_data_sources.dart';
import 'package:peanut_app/features/profile/domain/repositories/i_account_information_repository.dart';

import '../../domain/entities/account_info_parent_entity.dart';

class AccountInformationRepository extends IAccountInformationRepository {
  final IAccountInformationDataSource accountInformationDataSource;

  AccountInformationRepository({
    required this.accountInformationDataSource,
  });


  @override
  Future<Either<Failure, AccountInfoParentEntity>> getAccountInformation() async{
    try {
      AccountInfoParentEntity result = await accountInformationDataSource.getAccountInformation();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.errorMessage, code: e.code));
    }
  }

}
