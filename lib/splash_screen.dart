import 'package:flutter/material.dart';
import 'package:quiz/core/widgets/simple_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SimpleText(
          'Splash Screen',
          color: Colors.black,
          fontSize: 30,
        ),
      ),
    );
  }
}
