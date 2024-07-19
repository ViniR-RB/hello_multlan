import 'package:flutter_modular/flutter_modular.dart';
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
  void binds(Injector i) {}
  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.module("/auth", module: AuthModule());
    r.module("/box", module: BoxModule());
    r.child(Modular.initialRoute, child: (context) => const SplashPage());
  }
}
