import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/core_module.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_edit_controller.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_form_controller.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_map_controller.dart';
import 'package:hellomultlan/app/modules/box/gateway/box_gateway.dart';
import 'package:hellomultlan/app/modules/box/gateway/box_gateway_impl.dart';
import 'package:hellomultlan/app/modules/box/pages/box_detail.dart';
import 'package:hellomultlan/app/modules/box/pages/box_edit.dart';
import 'package:hellomultlan/app/modules/box/pages/box_form.dart';
import 'package:hellomultlan/app/modules/box/pages/box_hub.dart';
import 'package:hellomultlan/app/modules/box/pages/box_map.dart';

class BoxModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    i.addLazySingleton<BoxGateway>(BoxGatewayImpl.new);
    i.addLazySingleton(BoxFormController.new);
    i.addLazySingleton(BoxMapController.new);
    i.add(() =>
        BoxEditController(boxModel: Modular.args.data, gateway: Modular.get()));
  }

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const BoxHub());
    r.child("/map", child: (_) => BoxMapPage(controller: Modular.get()));
    r.child("/form", child: (_) => BoxFormPage(controller: Modular.get()));
    r.child("/detail", child: (_) => BoxDetail(controller: Modular.get()));
    r.child("/edit",
        child: (_) => BoxEdit(controller: Modular.args.data),
        maintainState: false);
  }
}
