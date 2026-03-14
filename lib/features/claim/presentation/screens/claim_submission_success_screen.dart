import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_mobile/navigation/navigation.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/extensions/build_context_extensions.dart';
import 'package:insurance_mobile/shared/layout/layout.dart';
import 'package:insurance_mobile/shared/widgets/widgets.dart';

class ClaimSubmissionSuccessScreen extends StatelessWidget {
  const ClaimSubmissionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: context.l10n.claimSuccessTitle,
      automaticallyImplyLeading: false,
      padding: context.pagePadding,
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(AppSpacing.xl),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Icon(
                    Icons.check_rounded,
                    color: context.colorScheme.secondary,
                    size: AppSpacing.xl,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                context.l10n.claimSuccessHeadline,
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                context.l10n.claimSuccessDescription,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: context.l10n.backToHome,
                onPressed: () {
                  context.go(AppRoutes.policiesPath);
                },
              ),
            ],
          ),
      ),
    );
  }
}
