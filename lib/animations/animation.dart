import 'package:flutter/material.dart';

class SlideTransitionAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const SlideTransitionAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    final animation = ModalRoute.of(context)?.animation;
    final secondaryAnimation = ModalRoute.of(context)?.secondaryAnimation;

    if (animation == null || secondaryAnimation == null) {
      return child;
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      )),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1, 0),
        ).animate(CurvedAnimation(
          parent: secondaryAnimation,
          curve: Curves.easeIn,
        )),
        child: child,
      ),
    );
  }
}
