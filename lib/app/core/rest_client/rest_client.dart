import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:hellomultlan/app/core/configuration/configuration.dart';
import 'package:hellomultlan/app/core/rest_client/interceptors/auth_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestClient extends DioForNative {
  RestClient({required final Future<SharedPreferences> prefs})
      : super(
          BaseOptions(
            baseUrl: Configuration.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
      AuthInterceptor(prefs: prefs, restClient: this)
    ]);
  }
  RestClient get auth {
    options.extra["DIO_AUTH_KEY"] = true;
    return this;
  }

  RestClient get unauth {
    options.extra["DIO_AUTH_KEY"] = false;
    return this;
  }
}
