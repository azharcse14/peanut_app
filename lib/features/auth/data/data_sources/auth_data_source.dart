import 'dart:developer';

import 'package:peanut_app/features/auth/data/data_sources/i_auth_data_source.dart';
import 'package:peanut_app/features/auth/data/models/login_model.dart';
import 'package:peanut_app/core/api/api_endpoints.dart';
import 'package:peanut_app/core/network/i_network_client.dart';

class AuthDataSource extends IAuthDataSource {
  final INetworkClient networkClient;

  AuthDataSource({
    required this.networkClient,
  });

  @override
  Future<LoginModel> login(
      {required int userId, required String password}) async {
    Map<String, dynamic> values = {"login": userId, "password": password};
    // Map<String, dynamic> values = {"login": 2088888, "password": 'ral11lod'};

    var result = await networkClient.post(
      paramas: PostParams(
        endPoint: APIEndPoints.loginEndPoint,
        body: values,
      ),
    );

    log('login result: $result');
    LoginModel response = LoginModel.fromJson(result);
    log('login response: $response');

    return response;
  }
}
