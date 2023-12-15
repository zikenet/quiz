import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz/core/network/network_info.dart';
import 'package:quiz/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:quiz/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:quiz/features/auth/domain/repositories/auth_repository.dart';
import 'package:quiz/features/auth/domain/use_cases/get_current_user.dart';
import 'package:quiz/features/auth/domain/use_cases/get_signed_in_user.dart';
import 'package:quiz/features/auth/domain/use_cases/logout.dart';
import 'package:quiz/features/auth/domain/use_cases/sign_in_with_google.dart';
import 'package:quiz/features/auth/presentation/business_logic/bloc/auth_bloc.dart';
import 'package:quiz/features/auth/presentation/business_logic/cubit/signUp/sign_up_cubit.dart';
import 'package:quiz/features/trivia/data/data_sources/player_remote_data_source.dart';
import 'package:quiz/features/trivia/data/data_sources/trivia_remote_data_source.dart';
import 'package:quiz/features/trivia/data/models/question_model.dart';
import 'package:quiz/features/trivia/data/models/trivia_model.dart';
import 'package:quiz/features/trivia/data/repositories/player_repository_impl.dart';
import 'package:quiz/features/trivia/data/repositories/trivia_repository_impl.dart';
import 'package:quiz/features/trivia/domain/repositories/player_repository.dart';
import 'package:quiz/features/trivia/domain/repositories/trivia_repository.dart';
import 'package:quiz/features/trivia/domain/use_cases/get_all_scores.dart';
import 'package:quiz/features/trivia/domain/use_cases/get_concrete_trivia.dart';
import 'package:quiz/features/trivia/domain/use_cases/get_user_score.dart';
import 'package:quiz/features/trivia/domain/use_cases/save_user_score.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/leader_board/leader_board_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/quiz/quiz_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/cubit/difficulty/difficulty_cubit.dart';
import 'package:quiz/features/trivia/presentation/widgets/ticker.dart';
import 'features/trivia/presentation/business_logic/bloc/timer/timer_bloc.dart';
import 'features/trivia/presentation/business_logic/bloc/trivia/trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Trivia
  sl.registerFactory(
    () => TriviaBloc(
      concreteTrivia: sl(),
    ),
  );
  sl.registerFactory(
    () => DifficultyCubit(),
  );
  sl.registerFactory(
    () => QuizBloc(
      getUserScore: sl(),
      saveUserScore: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => TimerBloc(
      ticker: const Ticker(),
    ),
  );
  sl.registerLazySingleton(
    () => AuthBloc(
      logout: sl(),
      signedInUser: sl(),
      currentUser: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SignUpCubit(
      signInWithGoogle: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => LeaderBoardBloc(
      getAllScores: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(
    () => SignInWithGoogle(
      authRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetCurrentUser(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => StreamSignedInUser(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => Logout(
      authRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetConcreteTrivia(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetUserScore(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SaveUserScore(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetAllScores(
      repository: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<TriviaRepository>(
    () => TriviaRepositoryImpl(
      remoteContract: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PlayerRepository>(
    () => PlayerRepositoryImpl(
      remoteContract: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteContract: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<TriviaRemoteDataSource>(
    () => TriviaRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<PlayerRemoteDataSource>(
    () => PlayerRemoteDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
      firestore: sl(),
    ),
  );
  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );
  // External
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  sl.registerLazySingleton<HiveInterface>(() {
    final HiveInterface hive = Hive;
    hive.init(appDocumentsDir.path);
    hive.registerAdapter<TriviaModel>(TriviaModelAdapter());
    hive.registerAdapter<QuestionModel>(QuestionModelAdapter());
    return hive;
  });
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
