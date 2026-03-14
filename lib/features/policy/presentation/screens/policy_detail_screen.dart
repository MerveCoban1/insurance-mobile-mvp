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
  const PolicyDetailScreen({
    super.key,
    required this.policyId,
    this.initialPolicy,
  });

  final String policyId;
  final Policy? initialPolicy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      title: context.l10n.policyDetails,
      padding: context.pagePadding,
      body: initialPolicy != null
          ? _PolicyDetailContent(policy: initialPolicy!)
          : ref
                .watch(selectedPolicyProvider(policyId))
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
                      ref.invalidate(policyListProvider);
                    },
                  ),
                  loading: () => const _PolicyDetailSkeleton(),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            policy.localizedType(context),
                            style: context.textTheme.headlineSmall,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                _DetailRow(
                  label: context.l10n.policyHolder,
                  value: policy.holderName,
                ),
                _DetailRow(
                  label: context.l10n.policyNumber,
                  value: policy.policyNumber,
                ),
                _DetailRow(
                  label: context.l10n.coverageAmount,
                  value: policy.formatCoverageAmount(context),
                ),
                _DetailRow(
                  label: context.l10n.startDate,
                  value: policy.formatStartDate(context),
                ),
                _DetailRow(
                  label: context.l10n.endDate,
                  value: policy.formatEndDate(context),
                ),
                _DetailRow(
                  label: context.l10n.status,
                  value: policy.localizedStatus(context),
                  isLast: true,
                ),
              ],
            ),
          ),
          SizedBox(height: spacing),
          AppCard(
            color: context.colorScheme.secondaryContainer.withValues(
              alpha: 0.45,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.policyClaimCtaTitle,
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  context.l10n.policyClaimCtaSubtitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: context.l10n.submitClaim,
                  isExpanded: Responsive.isMobile(context),
                  onPressed: () {
                    context.push(
                      AppRoutes.claimFormLocation(policyId: policy.id),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.md),
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
                Text(value, style: context.textTheme.titleSmall),
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
                    style: context.textTheme.titleSmall,
                  ),
                ),
              ],
            ),
    );
  }
}

class _PolicyDetailSkeleton extends StatelessWidget {
  const _PolicyDetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppSkeleton(width: AppSpacing.xxxl, height: AppSpacing.xxxl),
                  SizedBox(width: AppSpacing.md),
                  Expanded(child: AppSkeleton(height: 24)),
                ],
              ),
              SizedBox(height: AppSpacing.lg),
              AppSkeleton(width: 180, height: 14),
              SizedBox(height: AppSpacing.xs),
              AppSkeleton(width: 220, height: 14),
              SizedBox(height: AppSpacing.md),
              AppSkeleton(width: 84, height: 28),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.lg),
        AppSkeleton(width: 160, height: 20),
        SizedBox(height: AppSpacing.md),
        AppCard(
          child: Column(
            children: [
              AppSkeleton(height: 16),
              SizedBox(height: AppSpacing.md),
              AppSkeleton(height: 16),
              SizedBox(height: AppSpacing.md),
              AppSkeleton(height: 16),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.lg),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSkeleton(width: 180, height: 20),
              SizedBox(height: AppSpacing.xs),
              AppSkeleton(height: 14),
              SizedBox(height: AppSpacing.lg),
              AppSkeleton(height: 52),
            ],
          ),
        ),
      ],
    );
  }
}
