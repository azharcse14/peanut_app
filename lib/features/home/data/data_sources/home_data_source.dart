import 'dart:developer';

import 'package:peanut_app/features/home/data/data_sources/i_home_data_source.dart';
import 'package:peanut_app/core/network/i_network_client.dart';

import 'package:peanut_app/core/api/api_endpoints.dart';
import '../../../../core/di.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../models/open_trade_parent_model.dart';
import '../models/open_trades_model.dart';

class HomeDataSource extends IHomeDataSource {
  final INetworkClient networkClient;

  HomeDataSource({
    required this.networkClient,
  });

  @override
  Future<OpenTradeParentModel> getOpenTrades() async {
    Map<String, dynamic> values = {
      "login": injector<SharedPreferencesUtils>().getLogin()??0,
      "token": injector<SharedPreferencesUtils>().getToken()??'',
    };
    var result = await networkClient.post(
      paramas: PostParams(
        endPoint: APIEndPoints.openTradesEndPoint,
        body: values,
      ),
    );

    log('Get OpenTrades: $result');



    if (result == 'Access denied'){
      return const OpenTradeParentModel( message: 'Access denied', data: []);
    }

    List<OpenTradesModel> response = List<OpenTradesModel>.from(result.map((x) => OpenTradesModel.fromJson(x)));

    return OpenTradeParentModel( message: '', data: response);
  }
}
