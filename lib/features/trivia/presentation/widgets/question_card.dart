import 'package:flutter/material.dart';
import '../../../../core/widgets/simple_text.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  const QuestionCard({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: SimpleText(
          question,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          maxLines: 7,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
