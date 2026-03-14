import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_mobile/core/error/failures.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/presentation/providers/providers.dart';
import 'package:insurance_mobile/navigation/navigation.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/extensions/build_context_extensions.dart';
import 'package:insurance_mobile/shared/widgets/widgets.dart';

class PoliciesScreen extends ConsumerWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policiesAsync = ref.watch(policiesControllerProvider);

    return AppScaffold(
      title: context.l10n.policies,
      body: policiesAsync.when(
        data: (policies) {
          if (policies.isEmpty) {
            return const Center(child: Text('No active policies found.'));
          }

          return ListView.separated(
            itemCount: policies.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final policy = policies[index];

              return _PolicyCard(
                policy: policy,
                onTap: () {
                  context.push(AppRoutes.policyDetailLocation(policy.id));
                },
              );
            },
          );
        },
        error: (error, _) => ErrorView(
          message: error is Failure
              ? error.message
              : 'Unable to load policies.',
          actionLabel: context.l10n.retry,
          onActionPressed: () {
            ref.read(policiesControllerProvider.notifier).refresh();
          },
        ),
        loading: () => const LoadingIndicator(),
      ),
    );
  }
}

class _PolicyCard extends StatelessWidget {
  const _PolicyCard({required this.policy, required this.onTap});

  final Policy policy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(policy.productName, style: context.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          Text('Policy No: ${policy.policyNumber}'),
          Text('Status: ${policy.status}'),
          Text('Holder: ${policy.holderName}'),
        ],
      ),
    );
  }
}
