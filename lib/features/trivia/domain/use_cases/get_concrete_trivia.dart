import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz/core/use_cases/use_case.dart';

import '../../../../core/error/failure.dart';
import '../entities/trivia.dart';
import '../repositories/trivia_repository.dart';

class GetConcreteTrivia implements UseCase<Trivia, Params> {
  final TriviaRepository repository;

  GetConcreteTrivia({required this.repository});

  @override
  Future<Either<Failure, Trivia>> call(Params params) async {
    return await repository.getConcreteTrivia(
      params.category,
      params.difficulty,
      params.amount,
    );
  }
}

class Params extends Equatable {
  final int category;
  final int amount;
  final String difficulty;

  const Params({
    required this.category,
    required this.amount,
    required this.difficulty,
  });
  @override
  List<Object?> get props => [category, amount, difficulty];
}
