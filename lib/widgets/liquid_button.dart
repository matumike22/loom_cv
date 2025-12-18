import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class LiquidButton extends StatelessWidget {
  const LiquidButton({
    super.key,
    this.buttonText,
    this.buttonIcon,
    this.width,
    this.height,
    this.fontSize,
    this.borderRadius,
    this.onTap,
  });

  final String? buttonText;
  final IconData? buttonIcon;
  final double? width, height, fontSize, borderRadius;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 100),
        splashColor: Colors.purpleAccent.withValues(alpha: 0.2),
        hoverColor: Colors.purpleAccent.withValues(alpha: 0.1),
        child: GlassContainer(
          height: height ?? 50,
          width: width ?? 100,
          borderColor: Colors.white10,
          borderRadius: BorderRadius.circular(borderRadius ?? 100),
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
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (buttonIcon != null)
                Icon(buttonIcon, color: Colors.white, size: 20),

              if (buttonIcon != null && buttonText != null)
                const SizedBox(width: 8),

              if (buttonText != null)
                Text(
                  buttonText!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
