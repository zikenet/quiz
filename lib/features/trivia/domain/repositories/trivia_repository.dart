import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/trivia.dart';

abstract class TriviaRepository {
  Future<Either<Failure, Trivia>> getConcreteTrivia(
    int category,
    String difficulty,
    int amount,
  );
}
