import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/presentation/providers/providers.dart';
import 'package:insurance_mobile/features/policy/presentation/widgets/widgets.dart';
import 'package:insurance_mobile/navigation/navigation.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/extensions/build_context_extensions.dart';
import 'package:insurance_mobile/shared/layout/layout.dart';
import 'package:insurance_mobile/shared/widgets/widgets.dart';

class PolicyDetailScreen extends ConsumerWidget {
  const PolicyDetailScreen({super.key, required this.policyId});

  final String policyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      title: context.l10n.policyDetails,
      padding: context.pagePadding,
      body: ref
          .watch(policyDetailProvider(policyId))
          .when(
            data: (policy) {
              if (policy == null) {
                return ErrorView(message: context.l10n.policyNotFound);
              }

              return _PolicyDetailContent(policy: policy);
            },
            error: (_, _) => ErrorView(
              message: context.l10n.policyDetailLoadError,
              actionLabel: context.l10n.retry,
              onActionPressed: () {
                ref.invalidate(policyDetailProvider(policyId));
              },
            ),
            loading: () => const PolicyDetailSkeleton(),
          ),
    );
  }
}

class _PolicyDetailContent extends StatelessWidget {
  const _PolicyDetailContent({required this.policy});

  final Policy policy;

  @override
  Widget build(BuildContext context) {
    final spacing = context.pageSpacing;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCard(
            color: context.colorScheme.primaryContainer.withValues(alpha: 0.38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppSpacing.md),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Icon(
                          policy.icon,
                          size: AppSpacing.lg,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        policy.localizedType(context),
                        style: context.textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                AppLabeledValue(
                  label: context.l10n.policyHolder,
                  value: policy.holderName,
                ),
                AppLabeledValue(
                  label: context.l10n.policyNumber,
                  value: policy.policyNumber,
                ),
                AppLabeledValue(
                  label: context.l10n.coverageAmount,
                  value: policy.formatCoverageAmount(context),
                ),
                AppLabeledValue(
                  label: context.l10n.startDate,
                  value: policy.formatStartDate(context),
                ),
                AppLabeledValue(
                  label: context.l10n.endDate,
                  value: policy.formatEndDate(context),
                ),
                AppLabeledValue(
                  label: context.l10n.status,
                  value: policy.localizedStatus(context),
                  isLast: true,
                ),
              ],
            ),
          ),
          SizedBox(height: spacing),
          AppMessageCard(
            color: context.colorScheme.secondaryContainer.withValues(
              alpha: 0.45,
            ),
            title: context.l10n.policyClaimCtaTitle,
            subtitle: context.l10n.policyClaimCtaSubtitle,
            action: AppButton(
              label: context.l10n.submitClaim,
              isExpanded: Responsive.isMobile(context),
              onPressed: () {
                context.push(AppRoutes.claimFormLocation(policy.id));
              },
            ),
          ),
        ],
      ),
    );
  }
}
