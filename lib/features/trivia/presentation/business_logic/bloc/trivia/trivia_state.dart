part of 'trivia_bloc.dart';

sealed class TriviaState extends Equatable {
  const TriviaState();

  @override
  List<Object> get props => [];
}

final class Empty extends TriviaState {}

final class Loading extends TriviaState {}

final class Loaded extends TriviaState {
  final Trivia trivia;

  const Loaded({required this.trivia});
}

final class Error extends TriviaState {
  final String message;

  const Error({required this.message});
}
