import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TopPlayersShimmer extends StatelessWidget {
  final double radius;
  const TopPlayersShimmer({
    super.key,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey.withOpacity(0.5),
          child: CircleAvatar(
            radius: radius,
          ),
        ),
      ],
    );
  }
}
