import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/models/user_model.dart';
import 'package:hellomultlan/app/core/types/async_result.dart';

abstract interface class AppGateway {
  AsyncResult<UserModel, GatewayException> getMe();
}
