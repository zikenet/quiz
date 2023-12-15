import 'package:equatable/equatable.dart';
import 'package:quiz/features/trivia/domain/entities/question.dart';

class Trivia extends Equatable {
  final List<Question> questions;

  const Trivia({
    required this.questions,
  });

  @override
  List<Object?> get props => [questions];
}
