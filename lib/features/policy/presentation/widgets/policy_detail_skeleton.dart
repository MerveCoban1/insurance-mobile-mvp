import 'package:flutter/material.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/widgets/widgets.dart';

class PolicyDetailSkeleton extends StatelessWidget {
  const PolicyDetailSkeleton({super.key});

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
                  Expanded(child: AppSkeleton(height: AppSpacing.lg)),
                ],
              ),
              SizedBox(height: AppSpacing.lg),
              AppSkeleton(
                width: AppSpacing.xxl * 4 + AppSpacing.md,
                height: AppSpacing.md,
              ),
              SizedBox(height: AppSpacing.xs),
              AppSkeleton(
                width: AppSpacing.xxl * 5 + AppSpacing.lg,
                height: AppSpacing.md,
              ),
              SizedBox(height: AppSpacing.md),
              AppSkeleton(
                width: AppSpacing.xxl * 2 + AppSpacing.xxs,
                height: AppSpacing.lg + AppSpacing.xxs,
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.lg),
        AppSkeleton(
          width: AppSpacing.xxl * 4,
          height: AppSpacing.lg,
        ),
        SizedBox(height: AppSpacing.md),
        AppCard(
          child: Column(
            children: [
              AppSkeleton(height: AppSpacing.md),
              SizedBox(height: AppSpacing.md),
              AppSkeleton(height: AppSpacing.md),
              SizedBox(height: AppSpacing.md),
              AppSkeleton(height: AppSpacing.md),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.lg),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSkeleton(
                width: AppSpacing.xxl * 4 + AppSpacing.md,
                height: AppSpacing.lg,
              ),
              SizedBox(height: AppSpacing.xs),
              AppSkeleton(height: AppSpacing.md),
              SizedBox(height: AppSpacing.lg),
              AppSkeleton(height: AppSpacing.xxxl + AppSpacing.xxs),
            ],
          ),
        ),
      ],
    );
  }
}
