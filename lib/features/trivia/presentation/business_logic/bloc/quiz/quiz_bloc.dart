import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quiz/core/util/params.dart';
import 'package:quiz/features/auth/domain/entities/user.dart';
import 'package:quiz/features/trivia/data/models/question_model.dart';
import 'package:quiz/features/trivia/domain/use_cases/get_user_score.dart';
import 'package:quiz/features/trivia/domain/use_cases/save_user_score.dart';
import 'package:quiz/features/trivia/presentation/business_logic/cubit/difficulty/difficulty_cubit.dart';

import '../../../../domain/entities/question.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final pageController = PageController(initialPage: 0);
  final GetUserScore getUserScore;
  final SaveUserScore saveUserScore;

  QuizBloc({
    required this.getUserScore,
    required this.saveUserScore,
  }) : super(const QuizState()) {
    on<SubmitAnswer>(_onSubmitAnswer);
    on<NextQuestion>(_onNextQuestion);
    on<ResetQuiz>(_onRestQuiz);
    on<Initialize>(_onInitialize);
  }

  Future<void> _onSubmitAnswer(
    SubmitAnswer event,
    Emitter<QuizState> emit,
  ) async {
    if (state.answered) {
      return;
    } else if (event.question.correctAnswer == event.answer) {
      emit(
        state.copyWith(
          selectedAnswer: event.answer,
          correct: List.from(state.correct)
            ..add(event.question as QuestionModel),
          status: QuizStatus.correct,
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedAnswer: event.answer,
          incorrect: List.from(state.incorrect)
            ..add(event.question as QuestionModel),
          status: QuizStatus.incorrect,
        ),
      );
    }
  }

  Future<void> _onNextQuestion(
    NextQuestion event,
    Emitter<QuizState> emit,
  ) async {
    if (event.index < event.questions.length - 1) {
      pageController.animateToPage(
        event.index + 1,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
      emit(
        state.copyWith(
          selectedAnswer: '',
          pageIndex: event.index + 1,
          status: QuizStatus.initial,
        ),
      );
    } else {
      emit(state.copyWith(status: QuizStatus.loading));
      await saveUserScore(
        Params(
          played: playedQuestions(state.correct, state.played).toList(),
          score: state.score +
              calculateScore(
                state.correct,
                state.incorrect,
                state.played,
                event.difficulty,
              ),
          ranking: state.ranking,
        ),
      );
      final score = await getUserScore(const NonPropertyParams());
      emit(
        score.fold(
          (failure) => state.copyWith(
            selectedAnswer: '',
            status: QuizStatus.complete,
            score: state.score,
          ),
          (score) => state.copyWith(
            selectedAnswer: '',
            status: QuizStatus.complete,
            score: score.score,
            ranking: score.ranking,
            played: score.played.toSet(),
          ),
        ),
      );
    }
  }

  Future<void> _onInitialize(
    Initialize event,
    Emitter<QuizState> emit,
  ) async {
    final score = await getUserScore(const NonPropertyParams());
    emit(
      score.fold(
        (failure) => state,
        (score) => state.copyWith(
          score: score.score,
          ranking: score.ranking,
          played: score.played.toSet(),
        ),
      ),
    );
  }

  Future<void> _onRestQuiz(
    ResetQuiz event,
    Emitter<QuizState> emit,
  ) async {
    emit(QuizState(
      played: state.played,
      score: state.score,
      ranking: state.ranking,
    ));
  }

  double calculateScore(
    List correct,
    List incorrect,
    Set played,
    DifficultyStatus difficulty,
  ) {
    int totalQuestions = correct.length + incorrect.length;
    int answered = 0;
    if (played.isNotEmpty) {
      answered = correct.where((e) => !played.toList().contains(e)).length;
    } else {
      answered = correct.length;
    }
    final multiplier = difficulty == DifficultyStatus.easy
        ? 5
        : difficulty == DifficultyStatus.medium
            ? 10
            : 15;
    return double.parse(
        ((answered * multiplier) / totalQuestions).toStringAsFixed(2));
  }

  Set<Question> playedQuestions(List<Question> correct, Set<Question> played) {
    final playedList = played.toList();
    if (played.isNotEmpty) {
      final answered = correct.where((e) => !playedList.contains(e));
      return {...playedList, ...answered};
    } else {
      return {...correct};
    }
  }
}
