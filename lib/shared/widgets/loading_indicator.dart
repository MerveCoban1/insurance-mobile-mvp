import 'package:flutter/material.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/widgets/app_card.dart';
import 'package:insurance_mobile/shared/widgets/app_skeleton.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message != null) ...[
              Text(message!, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: AppSpacing.md),
            ],
            const AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSkeleton(width: 96, height: 12),
                  SizedBox(height: AppSpacing.md),
                  AppSkeleton(height: 20),
                  SizedBox(height: AppSpacing.xs),
                  AppSkeleton(width: 220, height: 20),
                  SizedBox(height: AppSpacing.lg),
                  AppSkeleton(height: 52),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
