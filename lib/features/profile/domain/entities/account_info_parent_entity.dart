import 'package:equatable/equatable.dart';

import 'account_information_entity.dart';

class AccountInfoParentEntity extends Equatable{
  final String? message;
  final AccountInformationEntity? data;


  const AccountInfoParentEntity({required this.message, required this.data});

  @override
  List<Object?> get props => [message, data];
}