import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/features/claim/presentation/providers/providers.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/extensions/build_context_extensions.dart';
import 'package:insurance_mobile/shared/widgets/widgets.dart';

class ClaimFormScreen extends ConsumerStatefulWidget {
  const ClaimFormScreen({super.key, this.initialPolicyId});

  final String? initialPolicyId;

  @override
  ConsumerState<ClaimFormScreen> createState() => _ClaimFormScreenState();
}

class _ClaimFormScreenState extends ConsumerState<ClaimFormScreen> {
  @override
  void initState() {
    super.initState();
    ref
        .read(claimFormControllerProvider.notifier)
        .initialize(policyId: widget.initialPolicyId);
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(claimFormControllerProvider);

    return AppScaffold(
      title: context.l10n.submitClaim,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.submitClaim,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Claim state is initialized and ready for the form UI.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            if (formState.policyId != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Policy reference: ${formState.policyId}',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
