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
            return AppMessageCard(
              centerAligned: true,
              leading: Icon(
                Icons.shield_outlined,
                size: AppSpacing.xl,
                color: context.colorScheme.primary,
              ),
              title: context.l10n.noActivePolicies,
              subtitle: context.l10n.noPoliciesDescription,
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
                      context.push(AppRoutes.policyDetailLocation(policy.id));
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
        loading: () => const PolicyListLoadingView(),
      ),
    );
  }
}

class _PolicyListIntroCard extends StatelessWidget {
  const _PolicyListIntroCard();

  @override
  Widget build(BuildContext context) {
    return AppMessageCard(
      color: context.colorScheme.primaryContainer.withValues(alpha: 0.42),
      title: context.l10n.policyListIntroTitle,
      subtitle: context.l10n.policyListIntroSubtitle,
    );
  }
}
