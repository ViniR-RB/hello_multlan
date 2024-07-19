import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/rest_client/rest_client.dart';
import 'package:hellomultlan/app/core/services/geolocator_service.dart';
import 'package:hellomultlan/app/core/services/image_picker_service.dart';

class CoreModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton(RestClient.new);
    i.addLazySingleton(GeolocatorService.new);
    i.addLazySingleton(ImagePickerService.new);
  }

  @override
  List<Module> get imports => throw UnimplementedError();

  @override
  void routes(RouteManager r) {}
}
