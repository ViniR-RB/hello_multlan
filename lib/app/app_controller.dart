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
}
