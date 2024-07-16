import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hellomultlan/app/core/services/geolocator_service.dart';
import 'package:hellomultlan/app/core/services/image_picker_service.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_form_controller.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_map_controller.dart';
import 'package:hellomultlan/app/modules/box/gateway/box_gateway.dart';
import 'package:hellomultlan/app/modules/box/gateway/box_gateway_impl.dart';
import 'package:hellomultlan/app/modules/box/pages/box_form.dart';
import 'package:hellomultlan/app/modules/box/pages/box_hub.dart';
import 'package:hellomultlan/app/modules/box/pages/box_map.dart';

class BoxModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<BoxGateway>((i) => BoxGatewayImpl(restClient: i())),
        Bind.lazySingleton<GeolocatorService>((i) => GeolocatorService()),
        Bind.lazySingleton((i) => ImagePickerService()),
        Bind.factory((i) => BoxFormController(
            gateway: i(), imagePickerService: i(), geolocatorService: i())),
        Bind.factory((i) => BoxMapController(
              gateway: i(),
            )),
      ];
  @override
  String get moduleRouteName => "/box";

  @override
  Map<String, WidgetBuilder> get pages => {
        "/": (_) => const BoxHub(),
        "/map": (_) => BoxMap(
              controller: Injector.get(),
            ),
        "/detail"
            "/form": (_) => BoxForm(
              controller: Injector.get(),
            ),
      };
}
