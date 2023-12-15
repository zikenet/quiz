import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlayersCardShimmer extends StatelessWidget {
  const PlayersCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.5),
      highlightColor: Colors.grey.withOpacity(0.8),
      child: Container(
        height: 65,
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
      ),
    );
  }
}
