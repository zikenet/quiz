import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/cubit/difficulty/difficulty_cubit.dart';
import 'package:quiz/features/trivia/presentation/widgets/difficulty_radio_button.dart';
import '../../../../core/widgets/simple_text.dart';
import '../business_logic/bloc/trivia/trivia_bloc.dart';

class DifficultyDialog extends StatelessWidget {
  const DifficultyDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DifficultyCubit, DifficultyState>(
      builder: (context, state) {
        return Wrap(
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            const SimpleText(
              'Choose Difficulty',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              textStyle: TextStyleEnum.bodyMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            DifficultyRadioButton(
              value: DifficultyStatus.easy,
              groupValue: state.status,
              onChanged: (value) {
                BlocProvider.of<DifficultyCubit>(context).changeOption(value);

                dispatchEvent(
                    context, BlocProvider.of<DifficultyCubit>(context).state);
                Navigator.pop(context);
                Navigator.pushNamed(context, '/trivia');
              },
              label: 'Easy',
            ),
            DifficultyRadioButton(
              value: DifficultyStatus.medium,
              groupValue: state.status,
              onChanged: (value) {
                BlocProvider.of<DifficultyCubit>(context).changeOption(value);

                dispatchEvent(
                    context, BlocProvider.of<DifficultyCubit>(context).state);
                Navigator.pop(context);
                Navigator.pushNamed(context, '/trivia');
              },
              label: 'Medium',
            ),
            DifficultyRadioButton(
              value: DifficultyStatus.hard,
              groupValue: state.status,
              onChanged: (value) {
                BlocProvider.of<DifficultyCubit>(context).changeOption(value);
                dispatchEvent(
                    context, BlocProvider.of<DifficultyCubit>(context).state);

                Navigator.pop(context);
                Navigator.pushNamed(context, '/trivia');
              },
              label: 'Hard',
            ),
          ],
        );
      },
    );
  }

  void dispatchEvent(BuildContext context, DifficultyState state) {
    BlocProvider.of<TriviaBloc>(context).add(
      GetConcreteTriviaEvent(
        difficulty: state.status.name,
        category: state.category,
        amount: state.questionAmount,
      ),
    );
  }
}
