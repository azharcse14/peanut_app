import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:peanut_app/core/error/failure.dart';
import 'package:peanut_app/features/profile/domain/entities/account_information_entity.dart';
import 'package:peanut_app/features/profile/domain/use_cases/account_information_usecase.dart';

import '../../../domain/entities/account_info_parent_entity.dart';

part 'account_information_event.dart';

part 'account_information_state.dart';

class AccountInformationBloc
    extends Bloc<AccountInformationEvent, AccountInformationState> {
  final AccountInformationUseCase accountInformationUseCase;

  AccountInfoParentEntity? _accountInformationEntity;

  AccountInfoParentEntity? get accountInformationEntity =>
      _accountInformationEntity;

  AccountInformationBloc({required this.accountInformationUseCase})
      : super(AccountInformationInitial()) {

    on<GetAccountInformation>((event, emit) async {

      emit(AccountInformationLoading());

      Either<Failure, AccountInfoParentEntity> result =
          await accountInformationUseCase();


      result.fold((l) => emit(AccountInformationError(error: l.message)), (r) {
        _accountInformationEntity = r;

        if(r.message==''){
          emit(AccountInformationSuccess(accountInformationEntity: r.data!));
        }else{
          emit( AccountInformationAccessDenied());
        }
      });
    });
  }
}
