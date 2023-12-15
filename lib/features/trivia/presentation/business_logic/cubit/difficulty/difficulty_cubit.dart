import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'difficulty_state.dart';

class DifficultyCubit extends Cubit<DifficultyState> {
  DifficultyCubit() : super((const DifficultyState()));

  void setCategory(int categoryId, int questionAmount) {
    emit(
      state.copyWith(
        category: categoryId,
        questionAmount: questionAmount,
      ),
    );
  }

  void changeOption(DifficultyStatus newOption) {
    emit(
      state.copyWith(
        status: newOption,
        seconds: newOption == DifficultyStatus.easy
            ? 30
            : newOption == DifficultyStatus.medium
                ? 20
                : 10,
      ),
    );
  }
}
