import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  late final ClaimFormNotifier _claimFormNotifier;

  @override
  void initState() {
    super.initState();
    _claimFormNotifier = ref.read(claimFormProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _claimFormNotifier.initialize(policyId: widget.initialPolicyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(claimFormProvider.select((state) => state.hasSubmitted), (
      previous,
      next,
    ) {
      if (previous == true || !next) {
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
                  AppMessageCard(
                    useCard: false,
                    title: context.l10n.claimFormIntroTitle,
                    subtitle: context.l10n.claimFormIntroSubtitle,
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
                        : context.formatDateShort(formState.incidentDate!),
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
                    onChanged: _claimFormNotifier.updateIncidentDescription,
                    errorText: _descriptionError(context, formState),
                  ),
                ],
              ),
            ),
            if (_submissionErrorText(context, formState) case final errorText?)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.md),
                child: AppFeedbackCard(
                  tone: AppFeedbackTone.error,
                  message: errorText,
                ),
              ),
            SizedBox(height: spacing),
            AppButton(
              label: formState.isSubmitting
                  ? context.l10n.submittingClaim
                  : context.l10n.submitClaim,
              onPressed: formState.isSubmitting
                  ? null
                  : _claimFormNotifier.submit,
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

    if (!mounted || selectedDate == null) {
      return;
    }

    controller.updateIncidentDate(selectedDate);
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
        child: AppLabeledValue(
          label: context.l10n.policyReference,
          value: policyId,
          compact: true,
          isLast: true,
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
