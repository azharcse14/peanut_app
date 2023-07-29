import 'package:dartz/dartz.dart';
import 'package:peanut_app/core/error/failure.dart';
import 'package:peanut_app/features/profile/domain/repositories/i_phone_number_repository.dart';

class PhoneNumberUseCase {
  IPhoneNumberRepository phoneNumberRepository;

  PhoneNumberUseCase({required this.phoneNumberRepository});

  Future<Either<Failure, String>> call() async =>
      await phoneNumberRepository.getPhoneNumber();
}
