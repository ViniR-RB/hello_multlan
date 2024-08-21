import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/models/user_model.dart';
import 'package:hellomultlan/app/core/rest_client/rest_client.dart';
import 'package:hellomultlan/app/modules/auth/states/logged_state.dart';

class AuthStore extends ValueNotifier<LoginState> {
  final RestClient _restClient;

  AuthStore({required RestClient restClient})
      : _restClient = restClient,
        super(UnLoggedState());

  _setStateAuth(LoginState state) {
    value = state;
  }

  getUser() async {
    final Response(:data) = await _restClient.auth.get("/auth/me");

    var userResult = UserModel.fromMap(data);

    _setStateAuth(LoggedState(user: userResult));
  }
}
