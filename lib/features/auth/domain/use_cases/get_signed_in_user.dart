import 'package:quiz/core/util/params.dart';
import 'package:quiz/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/use_cases/use_case.dart';
import '../entities/user.dart';

class StreamSignedInUser implements UseCase<User, NonPropertyParams> {
  final AuthRepository repository;

  StreamSignedInUser({required this.repository});

  @override
  Stream<User> call(NonPropertyParams params) {
    return repository.streamSignedInUser();
  }
}
