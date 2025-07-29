import 'package:client/features/auth/data/model/user_model.dart';

abstract class AuthState {}

class AppInitialState extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;

  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}
