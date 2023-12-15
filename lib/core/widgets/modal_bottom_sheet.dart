import 'package:flutter/material.dart';

class ModalBottomSheet {
  final Widget child;

  ModalBottomSheet({
    required this.child,
  });

  void showBottomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      barrierDismissible: true,
      barrierLabel: 'Difficulty dialog',
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(animation),
          child: child,
        );
      },
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: child,
          ),
        );
      },
    );
  }
}
