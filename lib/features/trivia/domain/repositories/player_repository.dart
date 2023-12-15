import 'package:dartz/dartz.dart';
import 'package:quiz/core/error/failure.dart';
import 'package:quiz/features/trivia/domain/entities/player.dart';
import 'package:quiz/features/trivia/domain/entities/question.dart';

abstract class PlayerRepository {
  Future<Either<Failure, Player>> get();
  Future<Either<Failure, Unit>> update(
    List<Question> played,
    double score,
    int ranking,
  );
  Future<Either<Failure, List<Player>>> list();
}
