import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/core/util/params.dart';
import 'package:quiz/features/auth/domain/use_cases/get_signed_in_user.dart';
import 'package:quiz/features/auth/domain/use_cases/logout.dart';
import 'dart:async';
import '../../../domain/entities/user.dart';
import '../../../domain/use_cases/get_current_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.logout,
    required this.signedInUser,
    required this.currentUser,
  }) : super(
          currentUser(const NonPropertyParams()).isNotEmpty
              ? AuthState.authenticated(currentUser(const NonPropertyParams()))
              : const AuthState.unauthenticated(),
        ) {
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);
    _userSubscription = signedInUser(const NonPropertyParams()).listen(
      (user) => add(AuthUserChanged(user)),
    );
  }

  final Logout logout;
  final StreamSignedInUser signedInUser;
  final GetCurrentUser currentUser;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(AuthUserChanged event, Emitter<AuthState> emit) async {
    emit(
      event.user.isNotEmpty
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) {
    unawaited(logout(Params()));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
