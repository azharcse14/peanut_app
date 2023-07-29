import 'dart:developer';

import 'package:peanut_app/core/api/api_endpoints.dart';
import 'package:peanut_app/core/network/i_network_client.dart';
import '../../../../../core/di.dart';
import '../../../../../core/shared_prefs/shared_prefs.dart';
import 'i_phone_number_data_sources.dart';

class PhoneNumberDataSource extends IPhoneNumberDataSource {
  final INetworkClient networkClient;

  PhoneNumberDataSource({
    required this.networkClient,
  });

  @override
  Future<String> getPhoneNumber() async {
    Map<String, dynamic> values = {
      "login": injector<SharedPreferencesUtils>().getLogin()??0,
      "token": injector<SharedPreferencesUtils>().getToken()??'',
    };

    var result = await networkClient.post(
      paramas: PostParams(
        endPoint: APIEndPoints.lastFourNumberEndPoint,
        body: values,
      ),
    );

    log(' result: $result');


    return result;
  }
}