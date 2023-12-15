import 'package:dartz/dartz.dart';
import 'package:quiz/core/error/failure.dart';
import 'package:quiz/core/use_cases/use_case.dart';
import 'package:quiz/core/util/params.dart';
import 'package:quiz/features/trivia/domain/entities/player.dart';
import 'package:quiz/features/trivia/domain/repositories/player_repository.dart';

class GetUserScore implements UseCase<Player, NonPropertyParams> {
  final PlayerRepository repository;

  GetUserScore({required this.repository});

  @override
  Future<Either<Failure, Player>> call(NonPropertyParams params) async {
    return await repository.get();
  }
}
