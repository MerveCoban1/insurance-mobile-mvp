import 'package:flutter/material.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/widgets/app_card.dart';

enum AppFeedbackTone { info, error }

class AppFeedbackCard extends StatelessWidget {
  const AppFeedbackCard({
    super.key,
    required this.message,
    this.tone = AppFeedbackTone.info,
    this.action,
    this.centerAligned = false,
    this.icon,
  });

  final String message;
  final AppFeedbackTone tone;
  final Widget? action;
  final bool centerAligned;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = switch (tone) {
      AppFeedbackTone.info => colorScheme.primary,
      AppFeedbackTone.error => colorScheme.onErrorContainer,
    };
    final backgroundColor = switch (tone) {
      AppFeedbackTone.info => colorScheme.primaryContainer.withValues(
        alpha: 0.32,
      ),
      AppFeedbackTone.error => colorScheme.errorContainer.withValues(
        alpha: 0.72,
      ),
    };
    final resolvedIcon =
        icon ??
        switch (tone) {
          AppFeedbackTone.info => Icons.info_outline,
          AppFeedbackTone.error => Icons.error_outline,
        };
    final crossAxisAlignment = centerAligned
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centerAligned ? TextAlign.center : TextAlign.start;

    return AppCard(
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Icon(resolvedIcon, size: AppSpacing.xl, color: foregroundColor),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            textAlign: textAlign,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: foregroundColor),
          ),
          if (action != null) ...[
            const SizedBox(height: AppSpacing.lg),
            action!,
          ],
        ],
      ),
    );
  }
}
