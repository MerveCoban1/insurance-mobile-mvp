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
                    AppSkeleton(
                      width: AppSpacing.xxl + AppSpacing.xl,
                      height: AppSpacing.sm,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    AppSkeleton(height: AppSpacing.lg),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          AppSkeleton(height: AppSpacing.md),
          SizedBox(height: AppSpacing.xs),
          AppSkeleton(
            width: AppSpacing.xxl * 4 + AppSpacing.md,
            height: AppSpacing.md,
          ),
          SizedBox(height: AppSpacing.md),
          AppSkeleton(height: AppSpacing.xxxl + AppSpacing.xxs),
        ],
      ),
    );
  }
}
