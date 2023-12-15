part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

final class AuthUserChanged extends AuthEvent {
  const AuthUserChanged(this.user);
  final User user;
}
