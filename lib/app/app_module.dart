import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/app_controller.dart';
import 'package:hellomultlan/app/app_gateway.dart';
import 'package:hellomultlan/app/app_gateway_impl.dart';
import 'package:hellomultlan/app/core/core_module.dart';
import 'package:hellomultlan/app/modules/auth/auth_module.dart';
import 'package:hellomultlan/app/modules/box/box_module.dart';
import 'package:hellomultlan/app/pages/splash_page.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    i.add(AppController.new);
    i.add<AppGateway>(AppGatewayImpl.new);
  }

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.module("/auth", module: AuthModule());
    r.module("/box", module: BoxModule());
    r.child(Modular.initialRoute,
        child: (context) =>
            SplashPage(contoller: Modular.get<AppController>()));
  }
}
