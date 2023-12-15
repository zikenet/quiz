import 'package:flutter/material.dart';

import '../../../../core/widgets/simple_text.dart';

class UserScoreCard extends StatelessWidget {
  const UserScoreCard({
    super.key,
    required this.position,
    required this.name,
    required this.score,
    this.url,
  });
  final int position;
  final String name;
  final String? url;
  final double score;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            offset: const Offset(0.5, 0.5), //(x,y)
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SimpleText(position.toString()),
              const SizedBox(
                width: 20,
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: url != null ? NetworkImage(url!) : null,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          Expanded(
            child: SimpleText(
              name,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 1,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SimpleText(
            '$score',
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
