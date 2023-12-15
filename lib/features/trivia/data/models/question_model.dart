import 'package:hive/hive.dart';
import 'package:quiz/core/util/utility.dart';

import '../../domain/entities/question.dart';

part 'question_model.g.dart';

@HiveType(typeId: 0)
class QuestionModel extends Question {
  const QuestionModel({
    required super.category,
    required super.difficulty,
    required super.question,
    required super.correctAnswer,
    required super.answers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        category: json["category"],
        difficulty: json["difficulty"],
        question: Utility().htmlDecoder(json["question"]),
        correctAnswer: Utility().htmlDecoder(json["correct_answer"]),
        answers: List<String>.from(
          json["incorrect_answers"].map(
            (x) => Utility().htmlDecoder(x),
          ),
        )
          ..add(Utility().htmlDecoder(json["correct_answer"]))
          ..shuffle(),
      );
  factory QuestionModel.fromFirebase(Map<String, dynamic> json) =>
      QuestionModel(
        category: json["category"],
        difficulty: json["difficulty"],
        question: Utility().htmlDecoder(json["question"]),
        correctAnswer: Utility().htmlDecoder(json["correct_answer"]),
        answers: List<String>.from(
          json["answers"].map(
            (x) => Utility().htmlDecoder(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "difficulty": difficulty,
        "question": question,
        "correct_answer": correctAnswer,
        "answers": List<dynamic>.from(answers.map((x) => x)),
      };
}
