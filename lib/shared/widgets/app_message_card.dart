import 'package:flutter/material.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/widgets/app_card.dart';

class AppMessageCard extends StatelessWidget {
  const AppMessageCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.action,
    this.color,
    this.centerAligned = false,
    this.useCard = true,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? action;
  final Color? color;
  final bool centerAligned;
  final bool useCard;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final crossAxisAlignment = centerAligned
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centerAligned ? TextAlign.center : TextAlign.start;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(height: AppSpacing.lg),
        ],
        Text(title, style: textTheme.titleLarge, textAlign: textAlign),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle!,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: textAlign,
          ),
        ],
        if (action != null) ...[const SizedBox(height: AppSpacing.lg), action!],
      ],
    );

    if (!useCard) {
      return content;
    }

    return AppCard(color: color, child: content);
  }
}
