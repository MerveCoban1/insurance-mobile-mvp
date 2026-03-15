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
  ClaimFormScreen({super.key, required this.policyId})
    : assert(policyId.trim().isNotEmpty, 'policyId cannot be empty.');

  final String policyId;

  @override
  ConsumerState<ClaimFormScreen> createState() => _ClaimFormScreenState();
}

class _ClaimFormScreenState extends ConsumerState<ClaimFormScreen> {
  late final ClaimFormNotifier _claimFormNotifier;

  @override
  void initState() {
    super.initState();
    _claimFormNotifier = ref.read(claimFormProvider.notifier);
    _scheduleInitialization(widget.policyId);
  }

  @override
  void didUpdateWidget(covariant ClaimFormScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.policyId != widget.policyId) {
      _scheduleInitialization(widget.policyId);
    }
  }

  void _scheduleInitialization(String policyId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _claimFormNotifier.initialize(policyId);
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
    final isInitializing = formState.policyId != widget.policyId;

    if (isInitializing) {
      return AppScaffold(
        title: context.l10n.submitClaim,
        body: const LoadingIndicator(),
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
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    context.l10n.claimFormIntroSubtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _PolicyReferenceChip(policyId: widget.policyId),
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
                    minLines: 3,
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

    _claimFormNotifier.updateIncidentDate(selectedDate);
  }
}

class _PolicyReferenceChip extends StatelessWidget {
  const _PolicyReferenceChip({required this.policyId});

  final String policyId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.policy_outlined,
          size: AppSpacing.sm,
          color: context.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          context.l10n.policyReference,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          policyId,
          style: context.textTheme.titleSmall?.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _ClaimDateField extends StatelessWidget {
  const _ClaimDateField({
    required this.value,
    required this.hasValue,
    required this.onPressed,
  });

  final String value;
  final bool hasValue;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(AppSpacing.md),
      child: InkWell(
        onTap: onPressed,
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
