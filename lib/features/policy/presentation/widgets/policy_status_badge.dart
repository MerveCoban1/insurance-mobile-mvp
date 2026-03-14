import 'package:flutter/material.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/presentation/widgets/policy_presentation_mapper.dart';
import 'package:insurance_mobile/shared/design/design.dart';

class PolicyStatusBadge extends StatelessWidget {
  const PolicyStatusBadge({super.key, required this.policy});

  final Policy policy;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: policy.statusBackgroundColor(context),
        borderRadius: BorderRadius.circular(AppSpacing.xl),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          policy.localizedStatus(context),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: policy.statusForegroundColor(context),
          ),
        ),
      ),
    );
  }
}
