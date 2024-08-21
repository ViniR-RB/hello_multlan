import 'package:hellomultlan/app/core/either/unit.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/models/tokens.dart';
import 'package:hellomultlan/app/core/models/user_model.dart';
import 'package:hellomultlan/app/core/types/async_result.dart';

abstract interface class AuthGateway {
  AsyncResult<Unit, GatewayException> register(
      String email, String name, String password);
  AsyncResult<Tokens, GatewayException> login(String email, String password);
  AsyncResult<UserModel, GatewayException> whoIam();
}
