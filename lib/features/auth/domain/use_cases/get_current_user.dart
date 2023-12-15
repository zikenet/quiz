import 'package:quiz/core/use_cases/use_case.dart';
import 'package:quiz/core/util/params.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser implements UseCase<User, NonPropertyParams> {
  final AuthRepository repository;

  GetCurrentUser({required this.repository});

  @override
  User call(NonPropertyParams params) {
    return repository.getCurrentUser();
  }
}
