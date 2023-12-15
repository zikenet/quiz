import 'package:flutter/material.dart';

import 'skeleton.dart';

class QuizShimmer extends StatelessWidget {
  const QuizShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close,
            ),
          ),
        ),
        title: Container(
          width: 274,
          height: 34,
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Skeleton(
            height: 10,
            width: 100,
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Skeleton(
                height: 194,
                width: 330,
              ),
              SizedBox(
                height: 20,
              ),
              Skeleton(height: 60, width: 330),
              Skeleton(height: 60, width: 330),
              Skeleton(height: 60, width: 330),
            ],
          ),
        ),
      ),
    );
  }
}
