import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class LiquidContainer extends StatelessWidget {
  const LiquidContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    required this.child,
  });
  final double? width, height, borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: height ?? 300,
      width: width ?? 500,
      borderColor: Colors.white10,
      borderRadius: BorderRadius.circular(borderRadius ?? 30),
      gradient: LinearGradient(
        colors: [
          Colors.grey.shade400.withValues(alpha: 0.20),
          Colors.grey.shade400.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderGradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.60),
          Colors.white.withValues(alpha: 0.10),
          Colors.purple.withValues(alpha: 0.05),
          Colors.purpleAccent.withValues(alpha: 0.6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.39, 0.40, 1.0],
      ),
      blur: 15.0,
      borderWidth: 1.5,
      elevation: 3.0,
      isFrostedGlass: true,
      shadowColor: Colors.black.withValues(alpha: 0.20),
      alignment: Alignment.center,
      frostedOpacity: 0.12,
      padding: EdgeInsets.all(20),
      child: child,
    );
  }
}
