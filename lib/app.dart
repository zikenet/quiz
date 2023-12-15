import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/features/auth/presentation/business_logic/bloc/auth_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/quiz/quiz_bloc.dart';

import 'config/routes.dart';
import 'config/theme.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Riddle Demo',
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: (context, child) => BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthStatus.authenticated:
              BlocProvider.of<QuizBloc>(context).add(
                Initialize(user: state.user),
              );
              _navigator.pushNamedAndRemoveUntil(
                '/home',
                (route) => false,
              );
              break;
            case AuthStatus.unauthenticated:
              _navigator.pushNamedAndRemoveUntil(
                '/',
                (route) => false,
              );
              break;
            default:
              _navigator.pushNamedAndRemoveUntil(
                '/splash',
                (route) => false,
              );
          }
        },
        child: child,
      ),
    );
  }
}
