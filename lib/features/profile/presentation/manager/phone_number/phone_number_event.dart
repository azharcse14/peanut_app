part of 'phone_number_bloc.dart';

abstract class PhoneNumberEvent extends Equatable {
  const PhoneNumberEvent();

  @override
  List<Object> get props => [];
}

class GetPhoneNumber extends PhoneNumberEvent {
  const GetPhoneNumber();
}

