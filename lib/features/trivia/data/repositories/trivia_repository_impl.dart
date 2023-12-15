import 'package:dartz/dartz.dart';
import 'package:quiz/core/error/exception.dart';

import 'package:quiz/core/error/failure.dart';
import 'package:quiz/core/network/network_info.dart';
import 'package:quiz/features/trivia/data/data_sources/trivia_remote_data_source.dart';

import 'package:quiz/features/trivia/domain/entities/trivia.dart';

import '../../domain/repositories/trivia_repository.dart';

class TriviaRepositoryImpl implements TriviaRepository {
  final TriviaRemoteDataSource remoteContract;
  final NetworkInfo networkInfo;

  TriviaRepositoryImpl({
    required this.remoteContract,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Trivia>> getConcreteTrivia(
    int category,
    String difficulty,
    int amount,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await remoteContract.getConcreteTrivia(
            category, difficulty, amount);

        return Right(remoteTrivia);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure());
      /* try {
        final localTrivia = await localContract.getLastTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      } */
    }
  }
}
