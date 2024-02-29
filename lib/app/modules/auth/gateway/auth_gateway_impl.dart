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
      String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
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
