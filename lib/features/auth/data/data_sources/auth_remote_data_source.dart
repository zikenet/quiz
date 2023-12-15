import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz/core/error/exception.dart';
import 'package:quiz/core/error/failure.dart';
import 'package:quiz/features/trivia/data/models/player_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// uses firebase and GoogleSignIn to log or sign in the user
  ///
  /// Throws a [LogInWithGoogleException, LogOutException].
  Future<Unit> loginWithGoogle();
  Future<Unit> logout();
  Stream<UserModel> getSignedInUser();
  UserModel getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.firestore,
  });

  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  @override
  Future<Unit> loginWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;

      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;

      credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await firebaseAuth.signInWithCredential(credential);
      return unit;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleException.fromCode(e.code);
    } catch (e) {
      throw AuthFailure(message: e.toString());
    }
  }

  @override
  Future<Unit> logout() async {
    try {
      await Future.wait([
        firebaseAuth.signOut(),
        googleSignIn.signOut(),
      ]);
      return unit;
    } catch (_) {
      throw LogOutException();
    }
  }

  @override
  Stream<UserModel> getSignedInUser() {
    return firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return UserModel.empty;
      return UserModel.fromFirebaseAuthUser(firebaseUser);
    });
  }

  CollectionReference<PlayerModel> getUsersCollection() {
    final userRef = firestore.collection('Score').withConverter<PlayerModel>(
          fromFirestore: (snapshots, _) =>
              PlayerModel.fromJson(snapshots.data()!),
          toFirestore: (score, _) => score.toJson(),
        );
    return userRef;
  }

  @override
  UserModel getCurrentUser() {
    return firebaseAuth.currentUser != null
        ? UserModel.fromFirebaseAuthUser(firebaseAuth.currentUser!)
        : UserModel.empty;
  }
}
