part of 'quiz_bloc.dart';

sealed class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class SubmitAnswer extends QuizEvent {
  final Question question;
  final String answer;

  const SubmitAnswer({
    required this.question,
    required this.answer,
  });
}

class NextQuestion extends QuizEvent {
  final List<Question> questions;
  final DifficultyStatus difficulty;
  final int index;

  const NextQuestion({
    required this.difficulty,
    required this.questions,
    required this.index,
  });
}

class Initialize extends QuizEvent {
  final User user;

  const Initialize({required this.user});
}

class ResetQuiz extends QuizEvent {}
