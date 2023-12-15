import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/quiz/quiz_bloc.dart';
import 'package:quiz/features/trivia/presentation/widgets/status_indicator.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 21,
        horizontal: 8,
      ),
      width: 327,
      height: 70,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            offset: const Offset(0.5, 0.5), //(x,y)
            blurRadius: 1.0,
          ),
        ],
      ),
      child: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatusIndicator(
                title: 'Ranking',
                value: state.ranking,
                url: 'assets/icons/trophy.svg',
              ),
              const VerticalDivider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              StatusIndicator(
                title: 'Points',
                value: state.score,
                url: 'assets/icons/coin.svg',
              ),
            ],
          );
        },
      ),
    );
  }
}
