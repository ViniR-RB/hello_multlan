import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hellomultlan/app/modules/auth/controller/login_controller.dart';
import 'package:hellomultlan/app/modules/auth/controller/register_controller.dart';
import 'package:hellomultlan/app/modules/auth/gateway/auth_gateway.dart';
import 'package:hellomultlan/app/modules/auth/gateway/auth_gateway_impl.dart';
import 'package:hellomultlan/app/modules/auth/pages/login_page.dart';
import 'package:hellomultlan/app/modules/auth/pages/register_page.dart';

class AuthModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
          (i) => RegisterController(authGateway: i()),
        ),
        Bind.lazySingleton(
          (i) => LoginController(authGateway: i()),
        ),
        Bind.lazySingleton<AuthGateway>((i) => AuthGatewayImpl(i()))
      ];
  @override
  String get moduleRouteName => "/auth";

  @override
  Map<String, WidgetBuilder> get pages => {
        "/login": (context) => LoginPage(
              controller: Injector.get<LoginController>(),
            ),
        "/register": (context) => RegisterPage(
              controller: Injector.get<RegisterController>(),
            ),
      };
}
