import 'package:flutter/material.dart';
import 'package:insurance_mobile/shared/design/design.dart';

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = AppDesignTokens.compactBorderRadius,
    this.margin,
  });

  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
