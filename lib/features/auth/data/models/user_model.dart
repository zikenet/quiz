import 'package:quiz/features/auth/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserModel extends User {
  const UserModel({
    required super.id,
    super.email,
    super.name,
    super.photo,
    super.score,
    super.ranking,
  });

  static const empty = UserModel(id: '');

  @override
  bool get isEmpty => this == UserModel.empty;

  @override
  bool get isNotEmpty => this != UserModel.empty;

  factory UserModel.fromFirebaseAuthUser(firebase_auth.User user) {
    var userModel = UserModel(
      id: user.uid,
      email: user.email,
      name: user.displayName,
      photo: user.photoURL,
    );
    return userModel;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        photo: json['photo'],
        score: json['score'],
        ranking: json['ranking'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'photo': photo,
        'score': score,
        'ranking': ranking,
      };
}
