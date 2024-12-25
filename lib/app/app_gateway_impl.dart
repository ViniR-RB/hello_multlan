import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hellomultlan/app/app_gateway.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/either/nil.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/models/user_model.dart';
import 'package:hellomultlan/app/core/rest_client/rest_client.dart';
import 'package:hellomultlan/app/core/types/async_result.dart';

class AppGatewayImpl implements AppGateway {
  final RestClient _restClient;
  AppGatewayImpl({required final RestClient restClient})
      : _restClient = restClient;
  @override
  AsyncResult<UserModel, GatewayException> getMe() async {
    try {
      final Response(:data) = await _restClient.auth.get("/api/auth/me");
      final userModel = UserModel.fromMap(data);
      return Sucess(userModel);
    } on DioException catch (e, s) {
      log("Erro em pegar o Usuário Corrente", error: e, stackTrace: s);
      return Failure(GatewayException("Erro em Pegar o usuário Corrent"));
    }
  }

  @override
  AsyncResult<Nil, GatewayException> healthCheck() async {
    try {
      await _restClient.unauth.get("");
      return Sucess(const Nil());
    } on DioException catch (e, s) {
      log("Api Offline", error: e, stackTrace: s);
      return Failure(GatewayException("Erro inesperado"));
    }
  }
}
