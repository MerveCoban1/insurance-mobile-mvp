import 'package:flutter/material.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/widgets/widgets.dart';

class PolicyCardSkeleton extends StatelessWidget {
  const PolicyCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppSkeleton(width: AppSpacing.xxxl, height: AppSpacing.xxxl),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSkeleton(width: 72, height: 12),
                    SizedBox(height: AppSpacing.xs),
                    AppSkeleton(height: 20),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          AppSkeleton(height: 14),
          SizedBox(height: AppSpacing.xs),
          AppSkeleton(width: 180, height: 14),
          SizedBox(height: AppSpacing.md),
          AppSkeleton(height: 52),
        ],
      ),
    );
  }
}
