part of 'leader_board_bloc.dart';

sealed class LeaderBoardEvent extends Equatable {
  const LeaderBoardEvent();

  @override
  List<Object> get props => [];
}

class GetAllScoresEvent extends LeaderBoardEvent {}
