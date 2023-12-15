import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/quiz/quiz_bloc.dart';
import '../../../../core/widgets/simple_text.dart';

class QuizProgressBar extends StatelessWidget {
  final int total;
  const QuizProgressBar({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 274,
      height: 34,
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, quizState) {
          return Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  color: const Color(0XFFFF9F41),
                  backgroundColor: Theme.of(context).colorScheme.shadow,
                  value: double.parse(
                      ((quizState.pageIndex + 1) / total).toStringAsFixed(2)),
                  borderRadius: BorderRadius.circular(4),
                  minHeight: 8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: SimpleText(
                  '${quizState.pageIndex + 1}/$total',
                  height: 0,
                  fontSize: 12,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
