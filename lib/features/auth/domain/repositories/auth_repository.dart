import 'package:dartz/dartz.dart';
import 'package:quiz/core/error/failure.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> loginWithGoogle();
  Future<Either<Failure, Unit>> logout();
  User getCurrentUser();
  Stream<User> streamSignedInUser();
}
