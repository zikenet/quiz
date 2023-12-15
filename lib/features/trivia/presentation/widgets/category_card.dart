import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/widgets/simple_text.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final int id;
  final String url;
  final int amount;
  const CategoryCard(
      {super.key,
      required this.name,
      required this.id,
      required this.url,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            offset: const Offset(0.5, 0.5), //(x,y)
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleText(
                name,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 5,
              ),
              SimpleText(
                '$amount questions',
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
          Positioned(
            top: -30,
            child: SvgPicture.asset(
              url,
            ),
          ),
        ],
      ),
    );
  }
}
