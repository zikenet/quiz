part of 'difficulty_cubit.dart';

enum DifficultyStatus { none, easy, medium, hard }

class DifficultyState extends Equatable {
  final int category;
  final DifficultyStatus status;
  final int questionAmount;
  final int seconds;

  const DifficultyState({
    this.category = 0,
    this.questionAmount = 0,
    this.status = DifficultyStatus.none,
    this.seconds = 30,
  });

  DifficultyState copyWith({
    int? category,
    int? seconds,
    int? questionAmount,
    DifficultyStatus? status,
  }) =>
      DifficultyState(
        category: category ?? this.category,
        status: status ?? this.status,
        questionAmount: questionAmount ?? this.questionAmount,
        seconds: seconds ?? this.seconds,
      );

  @override
  List<Object?> get props => [category, status, seconds, questionAmount];
}
