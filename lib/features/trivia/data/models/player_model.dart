import 'package:quiz/features/trivia/data/models/question_model.dart';
import 'package:quiz/features/trivia/domain/entities/player.dart';

class PlayerModel extends Player {
  const PlayerModel({
    required super.name,
    required super.email,
    required super.photoUrl,
    required super.played,
    required super.score,
    required super.ranking,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        name: json['name'],
        email: json['email'],
        photoUrl: json['photoUrl'],
        played: List<QuestionModel>.from(
            json["played"].map((x) => QuestionModel.fromFirebase(x))),
        score: json['score'],
        ranking: json['ranking'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'played': List<dynamic>.from(played.map((x) => x.toJson())),
        'score': score,
        'ranking': ranking,
      };
}
