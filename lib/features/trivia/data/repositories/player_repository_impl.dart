import 'package:dartz/dartz.dart';
import 'package:quiz/core/error/failure.dart';
import 'package:quiz/core/network/network_info.dart';
import 'package:quiz/features/trivia/data/data_sources/player_remote_data_source.dart';
import 'package:quiz/features/trivia/domain/entities/player.dart';
import 'package:quiz/features/trivia/domain/entities/question.dart';
import 'package:quiz/features/trivia/domain/repositories/player_repository.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final PlayerRemoteDataSource remoteContract;
  final NetworkInfo networkInfo;

  PlayerRepositoryImpl({
    required this.remoteContract,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Player>> get() async {
    if (await networkInfo.isConnected) {
      try {
        final userScore = await remoteContract.get();
        return Right(userScore);
      } catch (e) {
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> update(
    List<Question> played,
    double score,
    int ranking,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteContract.update(played, score, ranking);
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Player>>> list() async {
    if (await networkInfo.isConnected) {
      try {
        final scores = await remoteContract.list();
        return Right(scores);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
