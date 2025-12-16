import 'package:flutter/material.dart';

class CustomPadding extends StatelessWidget {
  const CustomPadding({
    super.key,
    required this.child,
    this.verticalPadding,
    this.horizontalPadding,
    this.maxWidth,
  });
  final Widget child;

  final double? verticalPadding, maxWidth, horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 20,
          vertical: verticalPadding ?? 20,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth ?? 900),
          child: child,
        ),
      ),
    );
  }
}
