import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.scaffoldBackgroundColor, Colors.black],
          end: Alignment.bottomRight,
          begin: Alignment.topLeft,
          stops: const [0.3, 0.9],
        ),
      ),
      child: child,
    );
  }
}
