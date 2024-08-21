import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/rest_client/interceptors/auth_interceptor.dart';
import 'package:hellomultlan/app/core/rest_client/rest_client.dart';
import 'package:hellomultlan/app/core/services/geolocator_service.dart';
import 'package:hellomultlan/app/core/services/image_picker_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void exportedBinds(Injector i) {
    i.addInstance<Future<SharedPreferences>>(SharedPreferences.getInstance());

    i.addLazySingleton(RestClient.new);
    i.addSingleton(AuthInterceptor.new);
    i.addLazySingleton(GeolocatorService.new);
    i.addLazySingleton(ImagePickerService.new);
  }
}
