import 'package:hive/hive.dart';
import 'package:quiz/features/trivia/data/models/question_model.dart';
import 'package:quiz/features/trivia/domain/entities/trivia.dart';

part 'trivia_model.g.dart';

@HiveType(typeId: 1)
class TriviaModel extends Trivia {
  @HiveField(0)
  final List<QuestionModel> results;
  const TriviaModel({
    required this.results,
  }) : super(questions: results);
  factory TriviaModel.fromJson(Map<String, dynamic> json) => TriviaModel(
        results: List<QuestionModel>.from(
            json["results"].map((x) => QuestionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
