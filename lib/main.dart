import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/features/auth/presentation/business_logic/bloc/auth_bloc.dart';
import 'package:quiz/features/auth/presentation/business_logic/cubit/signUp/sign_up_cubit.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/leader_board/leader_board_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/quiz/quiz_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/cubit/difficulty/difficulty_cubit.dart';
import 'package:quiz/firebase_options.dart';
import 'package:quiz/service_locator.dart';
import 'features/trivia/presentation/business_logic/bloc/timer/timer_bloc.dart';
import 'features/trivia/presentation/business_logic/bloc/trivia/trivia_bloc.dart';
import 'service_locator.dart' as dependency_injector;
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injector.init();
  await Firebase.initializeApp(
    // name: 'quiz',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const Quiz());
  });
}

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 885),
      builder: (context, widget) => MultiBlocProvider(
        providers: [
          BlocProvider<DifficultyCubit>(
            create: (BuildContext context) => sl<DifficultyCubit>(),
          ),
          BlocProvider<TriviaBloc>(
            create: (BuildContext context) => sl<TriviaBloc>(),
          ),
          BlocProvider<QuizBloc>(
            create: (BuildContext context) => sl<QuizBloc>(),
          ),
          BlocProvider(
            create: (BuildContext context) => sl<TimerBloc>(),
          ),
          BlocProvider(
            create: (BuildContext context) => sl<SignUpCubit>(),
          ),
          BlocProvider(
            create: (BuildContext context) => sl<AuthBloc>(),
          ),
          BlocProvider(
            create: (BuildContext context) => sl<LeaderBoardBloc>(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}
