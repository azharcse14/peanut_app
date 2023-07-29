import 'package:dartz/dartz.dart';
import 'package:peanut_app/features/home/domain/entities/open_trade_parent_entity.dart';
import 'package:peanut_app/core/error/failure.dart';


abstract class IHomeRepository {

//get service list 
 Future<Either<Failure, OpenTradeParentEntity>> getOpenTrades();

}
