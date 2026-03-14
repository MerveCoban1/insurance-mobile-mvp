import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:insurance_mobile/features/claim/presentation/providers/providers.dart';
import 'package:insurance_mobile/navigation/navigation.dart';
import 'package:insurance_mobile/shared/design/design.dart';
import 'package:insurance_mobile/shared/extensions/build_context_extensions.dart';
import 'package:insurance_mobile/shared/layout/layout.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      ref
          .read(claimFormProvider.notifier)
          .initialize(policyId: widget.initialPolicyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ClaimFormState>(claimFormProvider, (previous, next) {
      if (previous?.hasSubmitted == true || !next.hasSubmitted) {
        return;
      }

      context.go(AppRoutes.claimSuccessLocation());
    });

    final formState = ref.watch(claimFormProvider);
    final spacing = context.pageSpacing;

    if (formState.policyId == null) {
      return AppScaffold(
        title: context.l10n.submitClaim,
        body: ErrorView(message: context.l10n.policyReferenceRequired),
      );
    }

    return AppScaffold(
      title: context.l10n.submitClaim,
      padding: context.pagePadding,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              color: context.colorScheme.secondaryContainer.withValues(
                alpha: 0.42,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.claimFormIntroTitle,
                    style: context.textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    context.l10n.claimFormIntroSubtitle,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _PolicyReferenceCard(policyId: formState.policyId!),
                ],
              ),
            ),
            SizedBox(height: spacing),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.incidentDate,
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _ClaimDateField(
                    value: formState.incidentDate == null
                        ? context.l10n.claimIncidentDateHint
                        : _formatDate(context, formState.incidentDate!),
                    hasValue: formState.incidentDate != null,
                    enabled: !formState.isSubmitting,
                    onPressed: formState.isSubmitting
                        ? null
                        : () => _pickIncidentDate(context),
                  ),
                  if (_incidentDateError(context, formState) case final error?)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.xs),
                      child: Text(
                        error,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.error,
                        ),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    label: context.l10n.incidentDescription,
                    hintText: context.l10n.incidentDescriptionHint,
                    prefixIcon: const Icon(Icons.description_outlined),
                    maxLines: Responsive.value(
                      context: context,
                      mobile: 4,
                      tablet: 5,
                      desktop: 6,
                    ),
                    minLines: 4,
                    enabled: !formState.isSubmitting,
                    onChanged: ref
                        .read(claimFormProvider.notifier)
                        .updateIncidentDescription,
                    errorText: _descriptionError(context, formState),
                  ),
                ],
              ),
            ),
            if (_submissionErrorText(context, formState) case final errorText?)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.md),
                child: AppCard(
                  color: context.colorScheme.errorContainer,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: context.colorScheme.onErrorContainer,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          errorText,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: spacing),
            AppButton(
              label: formState.isSubmitting
                  ? context.l10n.submittingClaim
                  : context.l10n.submitClaim,
              onPressed: formState.isSubmitting
                  ? null
                  : ref.read(claimFormProvider.notifier).submit,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickIncidentDate(BuildContext context) async {
    final controller = ref.read(claimFormProvider.notifier);
    final state = ref.read(claimFormProvider);
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: state.incidentDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
    );

    if (selectedDate != null) {
      controller.updateIncidentDate(selectedDate);
    }
  }
}

class _PolicyReferenceCard extends StatelessWidget {
  const _PolicyReferenceCard({required this.policyId});

  final String policyId;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.policyReference,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(policyId, style: context.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

class _ClaimDateField extends StatelessWidget {
  const _ClaimDateField({
    required this.value,
    required this.hasValue,
    required this.enabled,
    required this.onPressed,
  });

  final String value;
  final bool hasValue;
  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(AppSpacing.md),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(AppSpacing.md),
        child: Ink(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outline),
            borderRadius: BorderRadius.circular(AppSpacing.md),
          ),
          child: Row(
            children: [
              Icon(
                Icons.event_outlined,
                color: hasValue
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  value,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: hasValue
                        ? colorScheme.onSurface
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? _incidentDateError(BuildContext context, ClaimFormState state) {
  if (!state.hasAttemptedSubmit || state.incidentDate != null) {
    return null;
  }

  return context.l10n.incidentDateRequired;
}

String? _descriptionError(BuildContext context, ClaimFormState state) {
  if (!state.hasAttemptedSubmit ||
      state.incidentDescription.trim().isNotEmpty) {
    return null;
  }

  return context.l10n.descriptionRequired;
}

String? _submissionErrorText(BuildContext context, ClaimFormState state) {
  return switch (state.submissionError) {
    ClaimFormSubmissionError.none => null,
    ClaimFormSubmissionError.missingPolicyReference =>
      context.l10n.policyReferenceRequired,
    ClaimFormSubmissionError.submissionFailed =>
      context.l10n.claimSubmissionFailed,
  };
}

String _formatDate(BuildContext context, DateTime date) {
  return DateFormat.yMMMd(
    Localizations.localeOf(context).toString(),
  ).format(date);
}
