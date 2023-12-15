part of 'quiz_bloc.dart';

enum QuizStatus { initial, correct, incorrect, complete, loading }

class QuizState extends Equatable {
  final String selectedAnswer;
  final Set<Question> played;
  final List<Question> correct;
  final List<Question> incorrect;
  final QuizStatus status;
  final int pageIndex;
  final int ranking;
  final double score;

  const QuizState({
    this.selectedAnswer = '',
    this.correct = const <Question>[],
    this.incorrect = const <Question>[],
    this.played = const {},
    this.status = QuizStatus.initial,
    this.ranking = 0,
    this.pageIndex = 0,
    this.score = 0,
  });

  bool get answered =>
      status == QuizStatus.incorrect || status == QuizStatus.correct;

  QuizState copyWith({
    String? selectedAnswer,
    List<Question>? correct,
    List<Question>? incorrect,
    Set<Question>? played,
    QuizStatus? status,
    int? pageIndex,
    int? ranking,
    double? score,
  }) =>
      QuizState(
        selectedAnswer: selectedAnswer ?? this.selectedAnswer,
        correct: correct ?? this.correct,
        incorrect: incorrect ?? this.incorrect,
        played: played ?? this.played,
        status: status ?? this.status,
        pageIndex: pageIndex ?? this.pageIndex,
        ranking: ranking ?? this.ranking,
        score: score ?? this.score,
      );

  @override
  List<Object?> get props => [
        selectedAnswer,
        correct,
        incorrect,
        status,
        pageIndex,
        played,
        ranking,
        score,
      ];
}
