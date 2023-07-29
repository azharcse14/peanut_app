part of 'account_information_bloc.dart';

abstract class AccountInformationState extends Equatable {
  const AccountInformationState();

  @override
  List<Object> get props => [];
}

class AccountInformationInitial extends AccountInformationState {}


class AccountInformationLoading extends AccountInformationState {}

class AccountInformationAccessDenied extends AccountInformationState {}

class AccountInformationError extends AccountInformationState {
  final String error;

  const AccountInformationError({required this.error});
}

class AccountInformationSuccess extends AccountInformationState {
  final AccountInformationEntity accountInformationEntity;

  const AccountInformationSuccess({
    required this.accountInformationEntity,
  });
}