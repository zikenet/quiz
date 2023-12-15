import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/timer/timer_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/cubit/difficulty/difficulty_cubit.dart';

import '../../../../core/widgets/simple_text.dart';

class QuizTimer extends StatelessWidget {
  const QuizTimer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            shape: BoxShape.circle,
          ),
          child: CircularPercentIndicator(
            radius: 35,
            lineWidth: 8.0,
            percent: state.duration /
                BlocProvider.of<DifficultyCubit>(context).state.seconds,
            circularStrokeCap: CircularStrokeCap.round,
            center: SimpleText(
              "${state.duration}",
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            progressColor: Theme.of(context).colorScheme.secondary,
            backgroundColor: Theme.of(context).colorScheme.shadow,
          ),
        );
      },
    );
  }
}
