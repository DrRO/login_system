// login_state.dart
import '../../models/login_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel model;

  LoginSuccess(this.model);
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}