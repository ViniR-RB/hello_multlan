import 'package:asyncstate/asyncstate.dart';
import 'package:hellomultlan/app/core/constants/constants.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/models/tokens.dart';
import 'package:hellomultlan/app/modules/auth/gateway/auth_gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LoginController with MessageStateMixin {
  final AuthGateway _authGateway;

  LoginController({required AuthGateway authGateway})
      : _authGateway = authGateway;

  final _isLogged = ValueSignal<bool>(false);
  bool get isLogged => _isLogged();

  final _isObscurePassword = ValueSignal<bool>(true);

  bool get isObscurePassword => _isObscurePassword();

  void toogleVisiblePassword() {
    _isObscurePassword.forceUpdate(!_isObscurePassword.value);
  }

  Future<void> login(String email, String password) async {
    final result = await _authGateway.login(email, password).asyncLoader();

    switch (result) {
      case Failure(exception: GatewayException(:final message)):
        showError(message);
      case Sucess(
          value: Tokens(
            acessToken: final acessToken,
            refreshToken: final refreshToken
          )
        ):
        await Future.any([
          SharedPreferences.getInstance().then((sp) => {
                sp.setString(Constants.acessToken, acessToken),
                sp.setString(Constants.refreshToken, refreshToken),
              })
        ]).asyncLoader();
        _isLogged.forceUpdate(true);
    }
  }
}
