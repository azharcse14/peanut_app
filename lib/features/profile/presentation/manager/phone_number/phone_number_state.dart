part of 'phone_number_bloc.dart';

abstract class PhoneNumberState extends Equatable {
  const PhoneNumberState();
  @override
  List<Object> get props => [];
}


class PhoneNumberInitial extends PhoneNumberState {}


class PhoneNumberLoading extends PhoneNumberState {}

class PhoneNumberError extends PhoneNumberState {
  final String error;

  const PhoneNumberError({required this.error});
}

class PhoneNumberSuccess extends PhoneNumberState {
  final String lastFourNumber;

   const PhoneNumberSuccess({
    required this.lastFourNumber,
  });
}