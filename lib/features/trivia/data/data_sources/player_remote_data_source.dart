import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:quiz/core/error/failure.dart';
import 'package:quiz/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:quiz/features/trivia/data/models/player_model.dart';
import 'package:quiz/features/trivia/domain/entities/question.dart';
import 'package:quiz/service_locator.dart';

abstract class PlayerRemoteDataSource {
  /// will store the users score and ranking in firestore
  ///
  Future<Unit> update(List<Question> played, double score, int ranking);
  Future<PlayerModel> create();
  Future<PlayerModel> get();
  Future<List<PlayerModel>> list();
}

class PlayerRemoteDataSourceImpl implements PlayerRemoteDataSource {
  final FirebaseFirestore firestore;

  PlayerRemoteDataSourceImpl({required this.firestore});

  @override
  Future<Unit> update(List<Question> played, double score, int ranking) async {
    final userRef = userDocument();
    final user = sl<AuthRemoteDataSource>().getCurrentUser();
    final player = PlayerModel(
      played: played,
      score: score,
      ranking: ranking,
      name: user.name,
      email: user.email,
      photoUrl: user.photo,
    );
    return userRef.update(player.toJson()).then((value) async {
      await updateRanking();
      return unit;
    }, onError: (e) {
      throw NetworkFailure();
    });
  }

  @override
  Future<PlayerModel> get() async {
    final userRef = userDocument();
    final record = await userRef.get();

    if (record.exists) {
      return Future.value(record.data());
    } else {
      try {
        final player = await create();
        return player;
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  Future<PlayerModel> create() async {
    final user = sl<AuthRemoteDataSource>().getCurrentUser();
    final player = PlayerModel(
      played: const <Question>[],
      score: 0,
      ranking: 0,
      name: user.name,
      email: user.email,
      photoUrl: user.photo,
    );
    await userDocument()
        .withConverter<PlayerModel>(
          fromFirestore: (snapshots, _) =>
              PlayerModel.fromJson(snapshots.data()!),
          toFirestore: (player, _) => player.toJson(),
        )
        .set(player)
        .onError((error, stackTrace) {
      throw NetworkFailure();
    });

    return player;
  }

  CollectionReference<PlayerModel> getUsersCollection() {
    final scoreRef = firestore.collection('players').withConverter<PlayerModel>(
          fromFirestore: (snapshots, _) =>
              PlayerModel.fromJson(snapshots.data()!),
          toFirestore: (player, _) => player.toJson(),
        );
    return scoreRef;
  }

  Future<void> updateRanking() async {
    var ids = [];
    await getUsersCollection()
        .orderBy('score', descending: true)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        ids.add(docSnapshot.id);
      }
    });
    for (final (index, item) in ids.indexed) {
      final docRef = firestore.collection('players').doc(item);
      await docRef.update({'ranking': index + 1}).onError((e, _) {
        throw NetworkFailure();
      });
    }
  }

  @override
  Future<List<PlayerModel>> list() async {
    List<PlayerModel> scores = [];
    await getUsersCollection()
        .orderBy('score', descending: true)
        .get()
        .then((querySnapshot) {
      for (var docSnapShot in querySnapshot.docs) {
        scores.add(docSnapShot.data());
      }
    }).onError((error, stackTrace) {
      throw NetworkFailure();
    });
    return scores;
  }

  DocumentReference<PlayerModel> userDocument() {
    final user = sl<AuthRemoteDataSource>().getCurrentUser();
    return FirebaseFirestore.instance
        .collection('players')
        .doc(user.id)
        .withConverter<PlayerModel>(
          fromFirestore: (snapshots, _) =>
              PlayerModel.fromJson(snapshots.data()!),
          toFirestore: (player, _) => player.toJson(),
        );
  }
}
