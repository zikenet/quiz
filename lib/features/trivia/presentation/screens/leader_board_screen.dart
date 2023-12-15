import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/core/widgets/simple_text.dart';
import 'package:quiz/features/trivia/domain/entities/player.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/leader_board/leader_board_bloc.dart';
import 'package:quiz/features/trivia/presentation/widgets/players_card_shimmer.dart';
import 'package:quiz/features/trivia/presentation/widgets/top_players.dart';
import 'package:quiz/features/trivia/presentation/widgets/user_score_card.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.topCenter,
          begin: Alignment.bottomCenter,
          colors: [
            Color(0XFF3EB8D4),
            Color(0XFF1F8DA6),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const SimpleText(
            'Leader board',
            textStyle: TextStyleEnum.titleMedium,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        body: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TopPlayers(),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                        MediaQuery.of(context).size.width, 50),
                  ),
                ),
                child: SafeArea(
                  child: BlocBuilder<LeaderBoardBloc, LeaderBoardState>(
                    builder: (context, state) {
                      if (state is Loaded && state.players.length > 3) {
                        return PlayersList(
                          scores: state.players.sublist(3),
                        );
                      } else if (state is Loading) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return const PlayersCardShimmer();
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayersList extends StatelessWidget {
  final List<Player> scores;
  const PlayersList({
    super.key,
    required this.scores,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: scores.length,
      itemBuilder: (context, index) {
        return UserScoreCard(
          position: scores[index].ranking,
          name: scores[index].name!,
          score: scores[index].score,
          url: scores[index].photoUrl,
        );
      },
    );
  }
}
