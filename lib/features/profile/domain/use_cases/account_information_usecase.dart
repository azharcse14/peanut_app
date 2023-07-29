import 'package:dartz/dartz.dart';
import 'package:peanut_app/core/error/failure.dart';
import 'package:peanut_app/features/profile/domain/repositories/i_account_information_repository.dart';

import '../entities/account_info_parent_entity.dart';

class AccountInformationUseCase {
  IAccountInformationRepository accountInformationRepository;

  AccountInformationUseCase({required this.accountInformationRepository});

  Future<Either<Failure, AccountInfoParentEntity>> call() async =>
      await accountInformationRepository.getAccountInformation();
}
