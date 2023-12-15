import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz/features/auth/presentation/business_logic/cubit/signUp/sign_up_cubit.dart';
import '../../../../core/widgets/simple_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Load a Lottie file from your assets
                  Lottie.asset('assets/icons/3.json'),
                  const SimpleText(
                    "Let's Play Quiz",
                    textStyle: TextStyleEnum.headlineLarge,
                    fontWeight: FontWeight.bold,
                  ),
                  const SimpleText("Have fun"),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: GestureDetector(
          onTap: () {
            BlocProvider.of<SignUpCubit>(context).signUpWithGoogle();
            // Navigator.pushNamed(context, '/home');
          },
          child: Container(
            width: 327,
            height: 50,
            margin: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const SimpleText(
              'Start',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
