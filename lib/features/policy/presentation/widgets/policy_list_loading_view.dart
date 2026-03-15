import 'package:flutter/material.dart';
import 'package:insurance_mobile/features/policy/presentation/widgets/policy_card_skeleton.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/extensions/build_context_extensions.dart';
import 'package:insurance_mobile/shared/layout/layout.dart';
import 'package:insurance_mobile/shared/widgets/widgets.dart';

class PolicyListLoadingView extends StatelessWidget {
  const PolicyListLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.pageSpacing;
    final skeletonCount = Responsive.value(
      context: context,
      mobile: 3,
      tablet: 4,
      desktop: 4,
    );

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: skeletonCount + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.only(bottom: spacing),
            child: AppCard(
              color: context.colorScheme.primaryContainer.withValues(
                alpha: 0.32,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSkeleton(
                    width: AppSpacing.xxl * 4 + AppSpacing.xxs,
                    height: AppSpacing.sm,
                  ),
                  SizedBox(height: AppSpacing.md),
                  AppSkeleton(height: AppSpacing.lg),
                  SizedBox(height: AppSpacing.xs),
                  AppSkeleton(
                    width: AppSpacing.xxl * 5 + AppSpacing.lg,
                    height: AppSpacing.lg,
                  ),
                ],
              ),
            ),
          );
        }

        if (index == 1) {
          return Padding(
            padding: EdgeInsets.only(bottom: spacing),
            child: Text(
              context.l10n.loadingPolicies,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.only(
            bottom: index == skeletonCount + 1 ? 0 : spacing,
          ),
          child: const PolicyCardSkeleton(),
        );
      },
    );
  }
}
