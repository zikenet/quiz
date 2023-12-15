import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz/core/util/params.dart';
import 'package:quiz/features/auth/domain/use_cases/sign_in_with_google.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.signInWithGoogle}) : super(const SignUpState());

  final SignInWithGoogle signInWithGoogle;

  Future<void> signUpWithGoogle() async {
    emit(state.copyWith(status: SignUpStatus.inProgress));
    final result = await signInWithGoogle(const NonPropertyParams());
    emit(result.fold(
      (failure) => state.copyWith(
        status: SignUpStatus.failure,
        message: 'Error',
      ),
      (unit) => state.copyWith(
        status: SignUpStatus.success,
        message: 'Success',
      ),
    ));
  }
}
