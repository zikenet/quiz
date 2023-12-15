import 'package:flutter/material.dart';
import 'package:quiz/features/auth/presentation/screens/welcom_screen.dart';
import 'package:quiz/splash_screen.dart';

import '../features/trivia/presentation/screens/leader_board_screen.dart';
import '../features/trivia/presentation/screens/home.dart';
import '../features/trivia/presentation/screens/question_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );
      case '/splash':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case '/home':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case '/trivia':
        return MaterialPageRoute(
          builder: (_) => const QuestionScreen(),
        );

      case '/leaderBoard':
        return MaterialPageRoute(
          builder: (_) => const LeaderBoardScreen(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('Error'),
          ),
        );
      },
    );
  }
}
