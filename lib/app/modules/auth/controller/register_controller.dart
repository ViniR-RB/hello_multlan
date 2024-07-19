import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/modules/auth/gateway/auth_gateway.dart';
import 'package:signals_flutter/signals_flutter.dart';

class RegisterController with MessageStateMixin {
  final AuthGateway _authGateway;
  RegisterController({required AuthGateway authGateway})
      : _authGateway = authGateway;

  final _isObscurePassword = ValueSignal<bool>(true);

  bool get isObscurePassword => _isObscurePassword();

  void toogleVisiblePassword() {
    _isObscurePassword.forceUpdate(!_isObscurePassword.value);
  }

  final _isSuccessRegister = ValueSignal<bool>(false);
  bool get isSuccessRegister => _isSuccessRegister();

  final _isLoading = ValueSignal<bool>(false);
  void _setIsLoading() => _isLoading.set(!_isLoading.value, force: true);

  Future<void> register(String email, String name, String password) async {
    _setIsLoading();
    final result = await _authGateway.register(email, name, password);
    _setIsLoading();
    switch (result) {
      case Sucess():
        showSuccess("Sucesso ao Cadastrar Usuário");
        _isSuccessRegister.forceUpdate(true);
      case Failure(exception: GatewayException(message: final message)):
        showError(message);
    }
  }
}
