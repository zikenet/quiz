import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz/core/widgets/something_wrong.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/quiz/quiz_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/timer/timer_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/cubit/difficulty/difficulty_cubit.dart';
import 'package:quiz/features/trivia/presentation/widgets/question_screen_shimmer.dart';
import 'package:quiz/features/trivia/presentation/widgets/quiz_timer.dart';
import '../../../../core/widgets/simple_text.dart';
import '../business_logic/bloc/trivia/trivia_bloc.dart';
import '../widgets/answer_card.dart';
import '../widgets/question_card.dart';
import '../widgets/question_progress_bar.dart';
import '../widgets/quiz_result.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TriviaBloc, TriviaState>(
      builder: (context, triviaState) {
        if (triviaState is Loaded) {
          BlocProvider.of<TimerBloc>(context).add(
            TimerStarted(
              duration: BlocProvider.of<DifficultyCubit>(context).state.seconds,
            ),
          );

          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  BlocProvider.of<QuizBloc>(context).add(
                    ResetQuiz(),
                  );
                  BlocProvider.of<TimerBloc>(context).add(
                    const TimerReset(
                      duration: 0,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.shadow,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.shadow,
                  ),
                ),
              ),
              title: QuizProgressBar(
                total: triviaState.trivia.questions.length,
              ),
            ),
            body: BlocBuilder<QuizBloc, QuizState>(
              builder: (context, quizState) {
                if (quizState.status == QuizStatus.complete) {
                  return QuizResult(
                    state: quizState,
                    questions: triviaState.trivia.questions,
                  );
                } else if (quizState.status == QuizStatus.loading) {
                  return Center(
                    child: SpinKitSpinningLines(
                      color: Theme.of(context).colorScheme.secondary,
                      size: 100.0,
                    ),
                  );
                  ;
                } else {
                  return PageView.builder(
                    controller: context.read<QuizBloc>().pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: triviaState.trivia.questions.length,
                    itemBuilder: (context, position) {
                      return BlocListener<TimerBloc, TimerState>(
                        listener: (context, state) {
                          if (state is TimerRunComplete) {
                            BlocProvider.of<QuizBloc>(context).add(
                              NextQuestion(
                                difficulty:
                                    BlocProvider.of<DifficultyCubit>(context)
                                        .state
                                        .status,
                                questions: triviaState.trivia.questions,
                                index: quizState.pageIndex,
                              ),
                            );
                            if (quizState.status != QuizStatus.complete) {
                              BlocProvider.of<TimerBloc>(context).add(
                                TimerReset(
                                  duration:
                                      BlocProvider.of<DifficultyCubit>(context)
                                          .state
                                          .seconds,
                                ),
                              );
                              BlocProvider.of<TimerBloc>(context).add(
                                TimerStarted(
                                  duration:
                                      BlocProvider.of<DifficultyCubit>(context)
                                          .state
                                          .seconds,
                                ),
                              );
                            }
                          }
                        },
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 18,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    QuestionCard(
                                      question: triviaState
                                          .trivia.questions[position].question,
                                    ),
                                    const Positioned(
                                      left: 120,
                                      right: 120,
                                      top: -35,
                                      child: QuizTimer(),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: triviaState.trivia
                                        .questions[position].answers.length,
                                    itemBuilder: (context, index) {
                                      return AnswerCard(
                                        answer: triviaState.trivia
                                            .questions[position].answers[index],
                                        isCorrect: triviaState
                                                .trivia
                                                .questions[position]
                                                .answers[index] ==
                                            triviaState
                                                .trivia
                                                .questions[position]
                                                .correctAnswer,
                                        isSelected: triviaState
                                                .trivia
                                                .questions[position]
                                                .answers[index] ==
                                            quizState.selectedAnswer,
                                        isDisplayingAnswer: quizState.answered,
                                        onTap: () {
                                          BlocProvider.of<TimerBloc>(context)
                                              .add(const TimerPaused());
                                          context.read<QuizBloc>().add(
                                                SubmitAnswer(
                                                  question: triviaState.trivia
                                                      .questions[position],
                                                  answer: triviaState
                                                      .trivia
                                                      .questions[position]
                                                      .answers[index],
                                                ),
                                              );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            bottomNavigationBar: BlocBuilder<QuizBloc, QuizState>(
              builder: (context, quizState) {
                if (!quizState.answered) {
                  return const SizedBox.shrink();
                } else {
                  return SafeArea(
                    child: SizedBox(
                      height: 70,
                      width: 327,
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<QuizBloc>(context).add(
                            NextQuestion(
                              difficulty:
                                  BlocProvider.of<DifficultyCubit>(context)
                                      .state
                                      .status,
                              questions: triviaState.trivia.questions,
                              index: quizState.pageIndex,
                            ),
                          );
                          if (quizState.status != QuizStatus.loading) {
                            BlocProvider.of<TimerBloc>(context).add(
                              TimerReset(
                                duration:
                                    BlocProvider.of<DifficultyCubit>(context)
                                        .state
                                        .seconds,
                              ),
                            );
                            BlocProvider.of<TimerBloc>(context).add(
                              TimerStarted(
                                duration:
                                    BlocProvider.of<DifficultyCubit>(context)
                                        .state
                                        .seconds,
                              ),
                            );
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: SimpleText(
                              "Next",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        } else if (triviaState is Empty) {
          return const SomethingWentWrongScreen(
            message: '',
          );
        } else if (triviaState is Loading) {
          return const QuizShimmer();
        } else if (triviaState is Error) {
          return SomethingWentWrongScreen(
            message: triviaState.message,
          );
        } else {
          return const QuizShimmer();
        }
      },
    );
  }
}
