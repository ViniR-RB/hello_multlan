import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/core_module.dart';
import 'package:hellomultlan/app/modules/auth/controller/login_controller.dart';
import 'package:hellomultlan/app/modules/auth/controller/register_controller.dart';
import 'package:hellomultlan/app/modules/auth/gateway/auth_gateway.dart';
import 'package:hellomultlan/app/modules/auth/gateway/auth_gateway_impl.dart';
import 'package:hellomultlan/app/modules/auth/pages/login_page.dart';
import 'package:hellomultlan/app/modules/auth/pages/register_page.dart';
import 'package:hellomultlan/app/modules/auth/store/auth_store.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<AuthGateway>(AuthGatewayImpl.new);
    i.add(LoginController.new);
  }

  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton(AuthStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child("/register",
        child: (_) =>
            RegisterPage(controller: Modular.get<RegisterController>()));
    r.child("/login",
        child: (_) => LoginPage(controller: Modular.get<LoginController>()));
  }
}
