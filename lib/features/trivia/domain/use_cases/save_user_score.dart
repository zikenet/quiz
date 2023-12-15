import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz/core/error/failure.dart';
import 'package:quiz/core/use_cases/use_case.dart';
import 'package:quiz/features/trivia/domain/entities/question.dart';
import 'package:quiz/features/trivia/domain/repositories/player_repository.dart';

class SaveUserScore implements UseCase<Unit, Params> {
  final PlayerRepository repository;

  SaveUserScore({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(Params params) async {
    return await repository.update(params.played, params.score, params.ranking);
  }
}

class Params extends Equatable {
  final List<Question> played;
  final double score;
  final int ranking;

  const Params({
    required this.played,
    required this.score,
    required this.ranking,
  });

  @override
  List<Object?> get props => [score];
}
