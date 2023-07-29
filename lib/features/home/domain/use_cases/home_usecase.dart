import 'package:dartz/dartz.dart';
import 'package:peanut_app/core/error/failure.dart';
import 'package:peanut_app/features/home/domain/entities/open_trade_parent_entity.dart';
import 'package:peanut_app/features/home/domain/repository/i_home_repository.dart';


class HomeUseCase {
  IHomeRepository homeRepository;
  HomeUseCase({required this.homeRepository});

  Future<Either<Failure, OpenTradeParentEntity>> call() async =>
      await homeRepository.getOpenTrades();
}
