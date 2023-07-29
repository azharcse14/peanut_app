import 'package:dartz/dartz.dart';
import 'package:peanut_app/core/error/exceptions.dart';
import 'package:peanut_app/core/error/failure.dart';
import 'package:peanut_app/features/profile/data/data_sources/phone_number/i_phone_number_data_sources.dart';
import 'package:peanut_app/features/profile/domain/repositories/i_phone_number_repository.dart';

class PhoneNumberRepository extends IPhoneNumberRepository {
  final IPhoneNumberDataSource phoneNumberDataSource;

  PhoneNumberRepository({
    required this.phoneNumberDataSource,
  });


  @override
  Future<Either<Failure, String>> getPhoneNumber() async{
    try {
      String result = await phoneNumberDataSource.getPhoneNumber();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.errorMessage, code: e.code));
    }
  }

}
