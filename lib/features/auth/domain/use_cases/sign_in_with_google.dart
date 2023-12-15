import 'package:dartz/dartz.dart';
import 'package:quiz/core/use_cases/use_case.dart';
import 'package:quiz/core/util/params.dart';
import 'package:quiz/features/auth/domain/repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';

class SignInWithGoogle implements UseCase<Unit, NonPropertyParams> {
  final AuthRepository authRepository;

  SignInWithGoogle({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(NonPropertyParams params) async {
    return await authRepository.loginWithGoogle();
  }
}
