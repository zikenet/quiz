import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

// General Failures
class ServerFailure extends Failure {
  final String message;
  const ServerFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthFailure extends Failure {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class LogOutFailure extends Failure {
  @override
  List<Object?> get props => [];
}
