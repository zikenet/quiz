import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/auth_repository.dart';

class Logout implements UseCase<Unit, Params> {
  final AuthRepository authRepository;

  Logout({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(Params params) async {
    return await authRepository.logout();
  }
}

class Params extends Equatable {
  @override
  List<Object?> get props => [];
}
