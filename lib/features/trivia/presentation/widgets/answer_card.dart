import 'package:flutter/material.dart';

import '../../../../core/widgets/simple_text.dart';

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;
  const AnswerCard({
    super.key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isDisplayingAnswer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isDisplayingAnswer
              ? isSelected
                  ? isCorrect
                      ? Theme.of(context).colorScheme.tertiaryContainer
                      : Theme.of(context).colorScheme.errorContainer
                  : Colors.transparent
              : Colors.transparent,
          border: Border.all(
            width: 1.5,
            color: isDisplayingAnswer
                ? isSelected
                    ? isCorrect
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.error
                    : Colors.grey
                : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SimpleText(
                answer,
                maxLines: 3,
                fontSize: 18,
                height: 1,
                color: isDisplayingAnswer
                    ? isSelected
                        ? isCorrect
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.error
                        : Colors.grey.shade700
                    : Colors.grey.shade700,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            isDisplayingAnswer
                ? isSelected
                    ? isCorrect
                        ? Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 25,
                          )
                        : Icon(
                            Icons.cancel,
                            color: Theme.of(context).colorScheme.error,
                            size: 25,
                          )
                    : Container(
                        width: 20,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade700,
                          ),
                          shape: BoxShape.circle,
                        ),
                      )
                : Container(
                    width: 20,
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade700,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
