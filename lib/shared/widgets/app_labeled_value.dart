import 'package:flutter/material.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/extensions/build_context_extensions.dart';
import 'package:insurance_mobile/shared/layout/layout.dart';

class AppLabeledValue extends StatelessWidget {
  const AppLabeledValue({
    super.key,
    required this.label,
    required this.value,
    this.isLast = false,
    this.compact = false,
  });

  final String label;
  final String value;
  final bool isLast;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final spacing = compact ? AppSpacing.xs : AppSpacing.md;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : spacing),
      child: Responsive.isMobile(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  value,
                  style: compact
                      ? context.textTheme.titleMedium
                      : context.textTheme.titleSmall,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: compact
                        ? context.textTheme.titleMedium
                        : context.textTheme.titleSmall,
                  ),
                ),
              ],
            ),
    );
  }
}
