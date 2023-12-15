import 'package:flutter/material.dart';

import '../../../../core/widgets/simple_text.dart';

class TopPlayerCard extends StatelessWidget {
  final String userName;
  final double score;
  final double profileRadius;
  final Color borderColor;
  final String? url;
  final int position;

  const TopPlayerCard({
    super.key,
    required this.userName,
    required this.score,
    required this.profileRadius,
    required this.borderColor,
    required this.position,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(profileRadius),
              ),
              child: CircleAvatar(
                radius: profileRadius,
                backgroundImage: url != null ? NetworkImage(url!) : null,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: borderColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SimpleText('$position'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SimpleText(
          userName,
          fontWeight: FontWeight.normal,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5,
        ),
        SimpleText(
          '$score',
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
