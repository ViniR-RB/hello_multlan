import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/either/unit.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/models/tokens.dart';

abstract interface class AuthGateway {
  Future<Either<Unit, GatewayException>> register(
      String email, String name, String password);
  Future<Either<Tokens, GatewayException>> login(String email, String password);
}
