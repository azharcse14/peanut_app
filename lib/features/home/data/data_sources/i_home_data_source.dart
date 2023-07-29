import 'package:peanut_app/features/home/data/models/open_trade_parent_model.dart';

abstract class IHomeDataSource {

   Future<OpenTradeParentModel> getOpenTrades();



}
