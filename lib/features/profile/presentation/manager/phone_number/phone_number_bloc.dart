import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:peanut_app/core/error/failure.dart';
import 'package:peanut_app/features/profile/domain/use_cases/phone_number_usecase.dart';

part 'phone_number_event.dart';
part 'phone_number_state.dart';

class PhoneNumberBloc
    extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  final PhoneNumberUseCase phoneNumberUseCase;


  PhoneNumberBloc({required this.phoneNumberUseCase})
      : super(PhoneNumberInitial()) {
    on<GetPhoneNumber>((event, emit) async {
      emit(PhoneNumberLoading());
      Either<Failure, String> result =
      await phoneNumberUseCase();
      result.fold((l) => emit(PhoneNumberError(error: l.message)), (r) {
        emit(PhoneNumberSuccess(lastFourNumber: r));
      });
    });
  }
}
