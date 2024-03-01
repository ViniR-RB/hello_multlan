import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/either/unit.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/models/tokens.dart';
import 'package:hellomultlan/app/core/rest_client/rest_client.dart';

import './auth_gateway.dart';

class AuthGatewayImpl implements AuthGateway {
  final RestClient _rest;
  AuthGatewayImpl(this._rest);

  @override
  Future<Either<Tokens, GatewayException>> login(
      String email, String password) async {
    try {
      final Response(:Map data) = await _rest.unauth.post("auth", data: {
        "email": email,
        "password": password,
      });
      return Sucess(Tokens.fromMap(data));
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 403) {
        const message = "Email ou senha Incorretos";
        log(message, error: e, stackTrace: s);
        return Failure(GatewayException(message));
      }
      const message = "Erro ao fazer Login";
      log(message, error: e, stackTrace: s);
      return Failure(GatewayException(message));
    }
  }

  @override
  Future<Either<Unit, GatewayException>> register(
      String email, String name, String password) async {
    try {
      await _rest.unauth.post("users", data: {
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
}
