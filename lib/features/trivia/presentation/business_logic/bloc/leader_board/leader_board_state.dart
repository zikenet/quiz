part of 'leader_board_bloc.dart';

sealed class LeaderBoardState extends Equatable {
  const LeaderBoardState();

  @override
  List<Object> get props => [];
}

final class Empty extends LeaderBoardState {}

final class Loading extends LeaderBoardState {}

final class Error extends LeaderBoardState {}

final class Loaded extends LeaderBoardState {
  final List<Player> players;

  const Loaded({required this.players});
}
