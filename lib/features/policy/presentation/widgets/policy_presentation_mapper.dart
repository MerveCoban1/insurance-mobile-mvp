import 'package:flutter/material.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/shared/extensions/build_context_extensions.dart';

extension PolicyPresentationMapper on Policy {
  String localizedType(BuildContext context) {
    return switch (type) {
      PolicyType.vehicle => context.l10n.vehicleInsurance,
      PolicyType.health => context.l10n.healthInsurance,
      PolicyType.home => context.l10n.homeInsurance,
    };
  }

  IconData get icon {
    return switch (type) {
      PolicyType.vehicle => Icons.directions_car_outlined,
      PolicyType.health => Icons.favorite_outline,
      PolicyType.home => Icons.home_outlined,
    };
  }

  String formatCoverageAmount(BuildContext context) {
    return context.formatCurrency(coverageAmount);
  }

  String formatStartDate(BuildContext context) {
    return context.formatDateShort(startDate);
  }

  String formatEndDate(BuildContext context) {
    return context.formatDateShort(endDate);
  }

  String localizedStatus(BuildContext context) {
    return switch (status) {
      PolicyStatus.active => context.l10n.policyStatusActive,
      PolicyStatus.inactive => context.l10n.policyStatusInactive,
      PolicyStatus.pending => context.l10n.policyStatusPending,
      PolicyStatus.expired => context.l10n.policyStatusExpired,
    };
  }

  Color statusForegroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return switch (status) {
      PolicyStatus.active => const Color(0xFF166534),
      PolicyStatus.pending => const Color(0xFF92400E),
      PolicyStatus.expired => colorScheme.error,
      PolicyStatus.inactive => colorScheme.onSurfaceVariant,
    };
  }

  Color statusBackgroundColor(BuildContext context) {
    return switch (status) {
      PolicyStatus.active => const Color(0xFFDCFCE7),
      PolicyStatus.pending => const Color(0xFFFEF3C7),
      PolicyStatus.expired => const Color(0xFFFEE2E2),
      PolicyStatus.inactive => const Color(0xFFE2E8F0),
    };
  }
}
