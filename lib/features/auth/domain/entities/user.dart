import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.id,
      this.email,
      this.name,
      this.photo,
      this.score = 0,
      this.ranking = 0});

  final String? email;

  final String id;

  final String? name;

  final String? photo;

  final double score;
  final int ranking;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name, photo];
}
