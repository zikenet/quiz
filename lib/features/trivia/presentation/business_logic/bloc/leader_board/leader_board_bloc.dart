import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz/core/util/params.dart';
import 'package:quiz/features/trivia/domain/entities/player.dart';
import 'package:quiz/features/trivia/domain/use_cases/get_all_scores.dart';

part 'leader_board_event.dart';
part 'leader_board_state.dart';

class LeaderBoardBloc extends Bloc<LeaderBoardEvent, LeaderBoardState> {
  final GetAllScores getAllScores;
  LeaderBoardBloc({required this.getAllScores}) : super(Empty()) {
    on<GetAllScoresEvent>(onGetAllScores);
  }

  Future<void> onGetAllScores(
    GetAllScoresEvent event,
    Emitter<LeaderBoardState> emit,
  ) async {
    emit(Loading());
    final result = await getAllScores(const NonPropertyParams());
    emit(
      result.fold(
        (failure) => Error(),
        (scores) => Loaded(players: scores),
      ),
    );
  }
}
