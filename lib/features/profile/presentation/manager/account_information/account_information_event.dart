part of 'account_information_bloc.dart';

abstract class AccountInformationEvent extends Equatable {
  const AccountInformationEvent();

  @override
  List<Object> get props => [];
}

class GetAccountInformation extends AccountInformationEvent {
  const GetAccountInformation();
}
