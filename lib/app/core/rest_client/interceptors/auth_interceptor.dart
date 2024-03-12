import 'package:dio/dio.dart';
import 'package:hellomultlan/app/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;
    const authHeaderKey = "Authorization";
    headers.remove(authHeaderKey);
    if (extra case {"DIO_AUTH_KEY": true}) {
      final sp = await SharedPreferences.getInstance();
      headers.addAll(
        {authHeaderKey: 'Bearer ${sp.getString(Constants.acessToken)}'},
      );
    }
    handler.next(options);
  }
}
