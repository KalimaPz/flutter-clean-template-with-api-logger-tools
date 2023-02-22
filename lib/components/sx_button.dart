import 'package:flutter/material.dart';

enum SxButtonShape {
  flat,
  rounded,
}

class SxButton extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final SxButtonShape shape;

  const SxButton(
      {super.key,
      this.child,
      this.backgroundColor,
      this.gradient,
      this.onTap,
      this.shape = SxButtonShape.flat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            gradient: gradient,
            color: gradient == null && backgroundColor == null
                ? Colors.blue[900]
                : backgroundColor,
            borderRadius: SxButtonShape.flat == shape
                ? BorderRadius.circular(5)
                : BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: DefaultTextStyle(
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.25),
            child: Center(child: child!)),
      ),
    );
  }
}
