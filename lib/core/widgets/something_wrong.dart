import 'package:flutter/material.dart';
import 'package:quiz/core/widgets/simple_text.dart';

class SomethingWentWrongScreen extends StatelessWidget {
  final String message;
  const SomethingWentWrongScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/something_wrong.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              children: [
                SimpleText(message),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0XFF3EB8D4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {},
                  child: SimpleText(
                    "Try Again".toUpperCase(),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
