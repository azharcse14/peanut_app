import 'dart:developer';

import 'package:peanut_app/core/api/api_endpoints.dart';
import 'package:peanut_app/core/network/i_network_client.dart';
import 'package:peanut_app/features/profile/data/models/account_information_model.dart';

import '../../../../../core/di.dart';
import '../../../../../core/shared_prefs/shared_prefs.dart';
import '../../models/account_info_parent_model.dart';
import 'i_account_information_data_sources.dart';

class AccountInformationDataSource extends IAccountInformationDataSource {
  final INetworkClient networkClient;

  AccountInformationDataSource({
    required this.networkClient,
  });

  @override
  Future<AccountInfoParentModel> getAccountInformation() async {
    Map<String, dynamic> values = {
      "login": injector<SharedPreferencesUtils>().getLogin()??0,
      "token": injector<SharedPreferencesUtils>().getToken()??'',
    };

    var result = await networkClient.post(
      paramas: PostParams(
        endPoint: APIEndPoints.accountInformationEndPoint,
        body: values,
      ),
    );

    log(' result: $result');

    if (result == 'Access denied'){
      return const AccountInfoParentModel( message: 'Access denied', data: null);
    }
    AccountInformationModel response = AccountInformationModel.fromJson(result);
    log(' response: $response');

    return AccountInfoParentModel( message: '', data: response);
  }
}