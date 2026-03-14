import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:insurance_mobile/l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  AppLocalizations get l10n => AppLocalizations.of(this);
  String get localeTag => Localizations.localeOf(this).toString();

  String formatDateShort(DateTime date) {
    return DateFormat.yMMMd(localeTag).format(date);
  }

  String formatCurrency(num amount) {
    return NumberFormat.simpleCurrency(locale: localeTag).format(amount);
  }
}
