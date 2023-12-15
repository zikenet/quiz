import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class Question extends Equatable {
  @HiveField(0)
  final String category;
  @HiveField(1)
  final String difficulty;
  @HiveField(2)
  final String question;
  @HiveField(3)
  final String correctAnswer;
  @HiveField(4)
  final List<String> answers;

  const Question({
    required this.category,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });

  @override
  List<Object?> get props => [
        category,
        // difficulty,
        question,
        correctAnswer,
        // answers,
      ];

  Map<String, dynamic> toJson() => {
        "category": category,
        "difficulty": difficulty,
        "question": question,
        "correct_answer": correctAnswer,
        "answers": List<dynamic>.from(answers.map((x) => x)),
      };
}
