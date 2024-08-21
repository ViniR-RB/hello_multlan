import 'package:hellomultlan/app/core/models/user_model.dart';

abstract base class LoginState {}

final class UnLoggedState extends LoginState {}

final class LoggedState extends LoginState {
  final UserModel user;

  LoggedState({required this.user});
}

final class LogoutState extends LoginState {}
