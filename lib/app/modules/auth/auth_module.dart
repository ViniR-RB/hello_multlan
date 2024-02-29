import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hellomultlan/app/modules/auth/pages/login_page.dart';
import 'package:hellomultlan/app/modules/auth/pages/register_page.dart';

class AuthModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => "/auth";

  @override
  Map<String, WidgetBuilder> get pages => {
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
      };
}
