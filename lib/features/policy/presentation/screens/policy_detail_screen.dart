import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:insurance_mobile/core/error/failures.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/presentation/providers/providers.dart';
import 'package:insurance_mobile/navigation/navigation.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/extensions/build_context_extensions.dart';
import 'package:insurance_mobile/shared/widgets/widgets.dart';

class PolicyDetailScreen extends ConsumerWidget {
  const PolicyDetailScreen({super.key, required this.policyId});

  final String policyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyAsync = ref.watch(selectedPolicyProvider(policyId));

    return AppScaffold(
      title: context.l10n.policyDetails,
      body: policyAsync.when(
        data: (policy) {
          if (policy == null) {
            return const ErrorView(message: 'Policy could not be found.');
          }

          return _PolicyDetailContent(policy: policy);
        },
        error: (error, _) => ErrorView(
          message: error is Failure ? error.message : 'Unable to load policy.',
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

class _PolicyDetailContent extends StatelessWidget {
  const _PolicyDetailContent({required this.policy});

  final Policy policy;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat.yMMMd();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(policy.productName, style: context.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.md),
              _DetailRow(label: 'Policy No', value: policy.policyNumber),
              _DetailRow(label: 'Holder', value: policy.holderName),
              _DetailRow(label: 'Status', value: policy.status),
              _DetailRow(
                label: 'Start Date',
                value: dateFormatter.format(policy.effectiveDate),
              ),
              _DetailRow(
                label: 'End Date',
                value: dateFormatter.format(policy.expiryDate),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: context.l10n.submitClaim,
          onPressed: () {
            context.push(AppRoutes.claimFormLocation(policyId: policy.id));
          },
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(child: Text(label, style: context.textTheme.bodyMedium)),
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
