import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
    ).format(coverageAmount);
  }

  String formatStartDate(BuildContext context) {
    return _formatDate(context, startDate);
  }

  String formatEndDate(BuildContext context) {
    return _formatDate(context, endDate);
  }

  String localizedStatus(BuildContext context) {
    return switch (status.trim().toLowerCase()) {
      'active' => context.l10n.policyStatusActive,
      'inactive' => context.l10n.policyStatusInactive,
      'pending' => context.l10n.policyStatusPending,
      'expired' => context.l10n.policyStatusExpired,
      _ => status,
    };
  }

  Color statusForegroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return switch (status.trim().toLowerCase()) {
      'active' => const Color(0xFF166534),
      'pending' => const Color(0xFF92400E),
      'expired' => colorScheme.error,
      'inactive' => colorScheme.onSurfaceVariant,
      _ => colorScheme.onSurface,
    };
  }

  Color statusBackgroundColor(BuildContext context) {
    return switch (status.trim().toLowerCase()) {
      'active' => const Color(0xFFDCFCE7),
      'pending' => const Color(0xFFFEF3C7),
      'expired' => const Color(0xFFFEE2E2),
      'inactive' => const Color(0xFFE2E8F0),
      _ => Theme.of(context).colorScheme.surfaceContainerHighest,
    };
  }
}

String _formatDate(BuildContext context, DateTime date) {
  return DateFormat.yMMMd(
    Localizations.localeOf(context).toString(),
  ).format(date);
}
