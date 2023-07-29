import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:peanut_app/core/error/exceptions.dart';

import 'i_network_client.dart';

class NetworkClient implements INetworkClient {
  final Dio dio;

  NetworkClient({required this.dio});

  @override
  Future<dynamic> get({required NetworkParams paramas}) async {
    Response response;

    try {
      response = await dio.get(
        paramas.endPoint,
        options: Options(
          contentType: paramas.contentType,
          headers: {
            // "content-length": content.length,
            "content-type": "application/json; charset=utf-8",
            "server": "Microsoft-IIS/10.0",
            "x-powered-by": "ASP.NET"
          },
        ),
      );

      return jsonEncode(response.data);
    } on DioError catch (e) {
      throw ServerException(
        errorMessage: e.message,
        errorData:
            e.response != null ? e.response!.data : e.requestOptions.data,
      );
    }
  }

  @override
  Future<dynamic> post({required PostParams paramas}) async {
    Response response;
    try {
      // dynamic formData;
      // if (paramas.body != null) {
      //   if (paramas.isJsonBody) {
      //     formData = jsonEncode(paramas.body);
      //   } else {
      //     formData = FormData.fromMap(paramas.body);
      //   }
      // }

      var content = utf8.encode(json.encode(paramas.body));
      response = await dio.post(
        paramas.endPoint,
        data: paramas.body,
        options: Options(
          contentType: paramas.contentType,
          headers: {
            "content-length": content.length,
            "content-type": "application/json; charset=utf-8",
          },
        ),
      );

      return response.data;
    } on DioError catch (e) {
      if (kDebugMode) print('post exception is $e');
      if (e.type == DioErrorType.other) {
        throw ServerException(errorMessage: 'No Internet connection!');
      } else
      if (e.type == DioErrorType.response) {
        return e.response!.data;
      } else {
        throw ServerException(
            errorMessage: e.message,
            errorData:
                e.response != null ? e.response!.data : e.requestOptions.data);
      }
    }
  }
}
