import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz/config/constants.dart';
import 'package:quiz/core/error/failure.dart';

import '../../../../domain/entities/trivia.dart';
import '../../../../domain/use_cases/get_concrete_trivia.dart';
part 'trivia_event.dart';
part 'trivia_state.dart';

class TriviaBloc extends Bloc<TriviaEvent, TriviaState> {
  final GetConcreteTrivia concreteTrivia;
  TriviaBloc({required this.concreteTrivia}) : super(Empty()) {
    on<GetConcreteTriviaEvent>(onGetConcreteTrivia);
  }

  Future<void> onGetConcreteTrivia(
    GetConcreteTriviaEvent event,
    Emitter<TriviaState> emit,
  ) async {
    emit(Loading());
    final result = await concreteTrivia(
      Params(
        category: event.category,
        amount: event.amount,
        difficulty: event.difficulty,
      ),
    );

    emit(
      result.fold(
        (failure) => Error(
          message: _mapFailureToMessage(failure),
        ),
        (trivia) => Loaded(trivia: trivia),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.toString();
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
