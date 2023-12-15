import 'package:equatable/equatable.dart';
import 'package:quiz/features/trivia/domain/entities/question.dart';

class Player extends Equatable {
  final List<Question> played;
  final double score;
  final int ranking;
  final String? name;
  final String? email;
  final String? photoUrl;

  const Player({
    required this.played,
    required this.score,
    required this.ranking,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [played, score, ranking, name, email, photoUrl];
}
