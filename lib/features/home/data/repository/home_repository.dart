import 'package:dartz/dartz.dart';
import 'package:peanut_app/features/home/data/data_sources/i_home_data_source.dart';
import 'package:peanut_app/features/home/domain/repository/i_home_repository.dart';
import 'package:peanut_app/core/error/exceptions.dart';
import 'package:peanut_app/core/error/failure.dart';

import '../models/open_trade_parent_model.dart';

class HomeRepository extends IHomeRepository {
  final IHomeDataSource homeDataSource;

  HomeRepository({
    required this.homeDataSource,
  });

   @override
  Future<Either<Failure, OpenTradeParentModel>> getOpenTrades() async {
    try {
      OpenTradeParentModel result = await homeDataSource.getOpenTrades();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.errorMessage, code: e.code));
    }
  }


}
