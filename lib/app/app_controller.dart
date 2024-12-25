import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hellomultlan/app/app_gateway.dart';
import 'package:hellomultlan/app/core/constants/constants.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController {
  final AppGateway _gateway;
  final Future<SharedPreferences> _sp;

  AppController({
    required final Future<SharedPreferences> sp,
    required AppGateway gateway,
  })  : _sp = sp,
        _gateway = gateway;

  final ValueNotifier<bool?> _isAuthenticated = ValueNotifier<bool?>(null);
  ValueNotifier<bool?> get isAuthenticated => _isAuthenticated;

  final ValueNotifier<bool> _logout = ValueNotifier<bool>(false);
  ValueNotifier<bool> get logout => _logout;

  final ValueNotifier<bool> _apiOffline = ValueNotifier<bool>(false);
  ValueNotifier<bool> get apiOffline => _apiOffline;

  Future<void> clearSpAndRedirect() async {
    final shared = await _sp;
    await shared.clear();
    _logout.value = true;
  }

  Future<void> checkToken() async {
    final shared = await _sp;

    final String? acessToken = shared.getString(Constants.acessToken);
    final String? refreshToken = shared.getString(Constants.refreshToken);

    if (acessToken == null && refreshToken == null) {
      _isAuthenticated.value = false;
    }
    final result = await _gateway.getMe();

    switch (result) {
      case Sucess(:final value):
        shared.setString(Constants.user, jsonEncode(value.toMap()));
        _isAuthenticated.value = true;
      case Failure(:final exception):
        _isAuthenticated.value = false;
    }
  }

  Future<void> healthCheckApi() async {
    _apiOffline.value = false;
    final result = await _gateway.healthCheck();

    switch (result) {
      case Sucess():
        _apiOffline.value = false;
        checkToken();
      case Failure():
        _apiOffline.value = true;
    }
  }
}
