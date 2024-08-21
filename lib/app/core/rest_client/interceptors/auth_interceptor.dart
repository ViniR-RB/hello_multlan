import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/constants/constants.dart';
import 'package:hellomultlan/app/core/models/tokens.dart';
import 'package:hellomultlan/app/core/rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AuthInterceptor extends Interceptor {
  final Future<SharedPreferences> _prefs;
  final RestClient _restClient;
  AuthInterceptor(
      {required final Future<SharedPreferences> prefs,
      required final RestClient restClient})
      : _prefs = prefs,
        _restClient = restClient;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;
    const authHeaderKey = "Authorization";
    headers.remove(authHeaderKey);
    if (extra case {"DIO_AUTH_KEY": true}) {
      final sp = await _prefs;
      headers.addAll(
        {authHeaderKey: 'Bearer ${sp.getString(Constants.acessToken)}'},
      );
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    log("Erro no Authentication Token", error: err);

    if (err.response?.statusCode == 401) {
      try {
        final sp = await _prefs;
        final refreshToken = sp.getString(Constants.refreshToken);

        if (refreshToken != null) {
          final response =
              await _restClient.auth.post("/api/auth/refresh", data: {
            "refreshToken": refreshToken,
          });

          final tokens = Tokens.fromMap(response.data);

          // Atualiza o accessToken e o refreshToken
          await Future.wait([
            sp.setString(Constants.acessToken, tokens.acessToken),
            sp.setString(Constants.refreshToken, tokens.refreshToken),
          ]);

          // Atualiza o header da requisição original com o novo accessToken
          err.requestOptions.headers["Authorization"] =
              'Bearer ${tokens.acessToken}';

          // Repete a requisição original com o novo token
          final responseRetry = await _restClient.fetch(err.requestOptions);
          return handler.resolve(responseRetry);
        }
      } catch (e) {
        log("Erro ao tentar refresh token: $e");
        Modular.to.navigate("/");
      }
    }

    // Se não for um erro 401 ou falhar no refresh, prossiga com o erro original
    handler.next(err);
  }
}
