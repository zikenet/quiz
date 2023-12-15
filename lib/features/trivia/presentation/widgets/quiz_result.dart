import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz/core/widgets/simple_text.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/leader_board/leader_board_bloc.dart';

import '../../domain/entities/question.dart';
import '../business_logic/bloc/quiz/quiz_bloc.dart';

class QuizResult extends StatelessWidget {
  final QuizState state;
  final List<Question> questions;
  const QuizResult({
    super.key,
    required this.state,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Lottie.asset(
          state.correct.length > state.incorrect.length
              ? 'assets/icons/trophy.json'
              : 'assets/icons/wrong.json',
        ),
        const SizedBox(
          height: 10.0,
        ),
        SimpleText(
          '${state.correct.length} out of ${questions.length}',
          fontSize: 26.0,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
        ),
        const SimpleText(
          'Correct',
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 40.0,
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<LeaderBoardBloc>(context).add(GetAllScoresEvent());
            Navigator.pushNamed(context, '/leaderBoard');
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: const Color(0XFF3EB8D4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: SimpleText(
                "Ranking",
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
