part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, success, inProgress, failure }

final class SignUpState extends Equatable {
  final SignUpStatus status;
  final String message;
  const SignUpState({
    this.status = SignUpStatus.initial,
    this.message = '',
  });

  SignUpState copyWith({
    SignUpStatus? status,
    String? message,
  }) {
    return SignUpState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, message];
}
