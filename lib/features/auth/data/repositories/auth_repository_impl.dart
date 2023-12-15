import 'package:dartz/dartz.dart';
import 'package:quiz/core/error/exception.dart';
import 'package:quiz/core/error/failure.dart';
import 'package:quiz/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:quiz/features/auth/domain/repositories/auth_repository.dart';

import '../../domain/entities/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteContract;

  AuthRepositoryImpl({
    required this.remoteContract,
  });

  @override
  Future<Either<Failure, Unit>> loginWithGoogle() async {
    try {
      await remoteContract.loginWithGoogle();
      return const Right(unit);
    } on LogInWithGoogleException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await remoteContract.logout();
      return const Right(unit);
    } on LogOutException catch (_) {
      return Left(LogOutFailure());
    }
  }

  @override
  Stream<User> streamSignedInUser() {
    return remoteContract.getSignedInUser().map((userModel) {
      return userModel;
    });
  }

  @override
  User getCurrentUser() {
    return remoteContract.getCurrentUser();
  }
}
