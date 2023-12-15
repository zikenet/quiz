part of 'trivia_bloc.dart';

sealed class TriviaEvent extends Equatable {
  const TriviaEvent();

  @override
  List<Object> get props => [];
}

class GetConcreteTriviaEvent extends TriviaEvent {
  final String difficulty;
  final int amount;
  final int category;

  const GetConcreteTriviaEvent({
    required this.difficulty,
    required this.category,
    required this.amount,
  });
}
