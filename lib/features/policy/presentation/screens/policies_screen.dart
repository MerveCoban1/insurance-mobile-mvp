import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_mobile/features/policy/presentation/providers/providers.dart';
import 'package:insurance_mobile/features/policy/presentation/widgets/widgets.dart';
import 'package:insurance_mobile/navigation/navigation.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/extensions/build_context_extensions.dart';
import 'package:insurance_mobile/shared/layout/layout.dart';
import 'package:insurance_mobile/shared/widgets/widgets.dart';

class PolicyListScreen extends ConsumerWidget {
  const PolicyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policiesAsync = ref.watch(policyListProvider);
    final spacing = context.pageSpacing;

    return AppScaffold(
      title: context.l10n.policies,
      padding: context.pagePadding,
      body: policiesAsync.when(
        data: (policies) {
          if (policies.isEmpty) {
            return AppCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shield_outlined,
                    size: AppSpacing.xl,
                    color: context.colorScheme.primary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    context.l10n.noActivePolicies,
                    style: context.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    context.l10n.noPoliciesDescription,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(policyListProvider.future),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: policies.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spacing),
                    child: const _PolicyListIntroCard(),
                  );
                }

                final policy = policies[index - 1];

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == policies.length ? 0 : spacing,
                  ),
                  child: PolicyCard(
                    policy: policy,
                    title: policy.localizedType(context),
                    policyNumberLabel:
                        '${context.l10n.policyNumber}: ${policy.policyNumber}',
                    startDateLabel:
                        '${context.l10n.startDate}: ${policy.formatStartDate(context)}',
                    onTap: () {
                      context.push(
                        AppRoutes.policyDetailLocation(policy.id),
                        extra: policy,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
        error: (_, _) => ErrorView(
          message: context.l10n.policyListLoadError,
          actionLabel: context.l10n.retry,
          onActionPressed: () {
            ref.invalidate(policyListProvider);
          },
        ),
        loading: () => _PolicyListLoadingView(spacing: spacing),
      ),
    );
  }
}

class _PolicyListIntroCard extends StatelessWidget {
  const _PolicyListIntroCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: context.colorScheme.primaryContainer.withValues(alpha: 0.42),
      child: AppSectionHeader(
        title: context.l10n.policyListIntroTitle,
        subtitle: context.l10n.policyListIntroSubtitle,
      ),
    );
  }
}

class _PolicyListLoadingView extends StatelessWidget {
  const _PolicyListLoadingView({required this.spacing});

  final double spacing;

  @override
  Widget build(BuildContext context) {
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
                  AppSkeleton(width: 164, height: 12),
                  SizedBox(height: AppSpacing.md),
                  AppSkeleton(height: 20),
                  SizedBox(height: AppSpacing.xs),
                  AppSkeleton(width: 220, height: 20),
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
