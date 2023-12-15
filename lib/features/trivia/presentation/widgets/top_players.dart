import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/leader_board/leader_board_bloc.dart';
import 'package:quiz/features/trivia/presentation/widgets/top_players_shimmer.dart';
import 'package:quiz/features/trivia/presentation/widgets/top_user_card.dart';

class TopPlayers extends StatelessWidget {
  const TopPlayers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderBoardBloc, LeaderBoardState>(
      builder: (context, state) {
        if (state is Loaded) {
          return state.players.length == 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: TopPlayerCard(
                        profileRadius: 40,
                        userName: '?',
                        score: 0,
                        borderColor: Colors.green,
                        position: 2,
                      ),
                    ),
                    Expanded(
                      child: TopPlayerCard(
                        profileRadius: 50,
                        userName: state.players[0].name!,
                        score: state.players[0].score,
                        borderColor: Colors.yellow,
                        position: 1,
                        url: state.players[0].photoUrl,
                      ),
                    ),
                    const Expanded(
                      child: TopPlayerCard(
                        profileRadius: 40,
                        userName: '?',
                        score: 0,
                        position: 3,
                        borderColor: Colors.orange,
                      ),
                    ),
                  ],
                )
              : state.players.length == 2
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TopPlayerCard(
                            profileRadius: 40,
                            userName: state.players[1].name!,
                            score: state.players[1].score,
                            borderColor: Colors.green,
                            position: 2,
                            url: state.players[1].photoUrl,
                          ),
                        ),
                        Expanded(
                          child: TopPlayerCard(
                            profileRadius: 50,
                            userName: state.players[0].name!,
                            score: state.players[0].score,
                            borderColor: Colors.yellow,
                            position: 1,
                            url: state.players[0].photoUrl,
                          ),
                        ),
                        const Expanded(
                          child: TopPlayerCard(
                            profileRadius: 40,
                            userName: '?',
                            score: 0,
                            position: 3,
                            borderColor: Colors.orange,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TopPlayerCard(
                            profileRadius: 40,
                            userName: state.players[1].name!,
                            score: state.players[1].score,
                            borderColor: Colors.green,
                            position: 2,
                            url: state.players[1].photoUrl,
                          ),
                        ),
                        Expanded(
                          child: TopPlayerCard(
                            profileRadius: 50,
                            userName: state.players[0].name!,
                            score: state.players[0].score,
                            borderColor: Colors.yellow,
                            position: 1,
                            url: state.players[0].photoUrl,
                          ),
                        ),
                        Expanded(
                          child: TopPlayerCard(
                            profileRadius: 40,
                            userName: state.players[2].name!,
                            score: state.players[2].score,
                            position: 3,
                            borderColor: Colors.orange,
                            url: state.players[2].photoUrl,
                          ),
                        ),
                      ],
                    );
        } else if (state is Loading) {
          return const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopPlayersShimmer(radius: 40),
              TopPlayersShimmer(radius: 50),
              TopPlayersShimmer(radius: 40),
            ],
          );
        } else {
          return const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TopPlayerCard(
                  profileRadius: 40,
                  userName: '?',
                  score: 0,
                  borderColor: Colors.green,
                  position: 2,
                ),
              ),
              Expanded(
                child: TopPlayerCard(
                  profileRadius: 50,
                  userName: '?',
                  score: 0,
                  borderColor: Colors.yellow,
                  position: 1,
                ),
              ),
              Expanded(
                child: TopPlayerCard(
                  profileRadius: 40,
                  userName: '?',
                  score: 0,
                  position: 3,
                  borderColor: Colors.orange,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
