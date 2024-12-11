import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/either/unit.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/models/tokens.dart';
import 'package:hellomultlan/app/core/models/user_model.dart';
import 'package:hellomultlan/app/core/rest_client/rest_client.dart';
import 'package:hellomultlan/app/core/types/async_result.dart';

import './auth_gateway.dart';

class AuthGatewayImpl implements AuthGateway {
  final RestClient _rest;
  AuthGatewayImpl(this._rest);

  @override
  AsyncResult<Tokens, GatewayException> login(
      String email, String password) async {
    try {
      final Response(:Map data) =
          await _rest.unauth.post("api/auth/login", data: {
        "email": email,
        "password": password,
      });
      return Sucess(Tokens.fromMap(data));
    } on DioException catch (e, s) {
      log("Erro ao fazer Login", error: e, stackTrace: s);
      return switch (e) {
        DioException(response: Response(statusCode: 404)) =>
          Failure(GatewayException("Email ou Senha Incorreto")),
        _ => Failure(GatewayException("Erro ao fazer Login"))
      };
    }
  }

  @override
  AsyncResult<Unit, GatewayException> register(
      String email, String name, String password) async {
    try {
      await _rest.unauth.post("api/auth/register", data: {
        "email": email,
        "name": name,
        "password": password,
      });
      return Sucess(unit);
    } on DioException catch (e, s) {
      const message = "Erro ao registrar usuário";
      log(message, error: e, stackTrace: s);
      return Failure(GatewayException(message));
    }
  }

  @override
  AsyncResult<UserModel, GatewayException> whoIam() async {
    try {
      final Response(:data) = await _rest.auth.get("api/auth/me");
      var userResult = UserModel.fromMap(data);
      return Sucess(userResult);
    } on DioException catch (e, s) {
      log("Houve um Errro inesperado", error: e, stackTrace: s);
      return Failure(GatewayException("Houve um Errro inesperado"));
    }
  }
}
