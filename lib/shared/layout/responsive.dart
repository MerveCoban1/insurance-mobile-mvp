import 'package:flutter/material.dart';
import 'package:insurance_mobile/shared/design/design.dart';

enum ScreenSize { mobile, tablet, desktop }

abstract final class Responsive {
  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1024;

  static ScreenSize fromWidth(double width) {
    if (width >= desktopBreakpoint) {
      return ScreenSize.desktop;
    }

    if (width >= tabletBreakpoint) {
      return ScreenSize.tablet;
    }

    return ScreenSize.mobile;
  }

  static ScreenSize of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return fromWidth(width);
  }

  static bool isMobile(BuildContext context) =>
      of(context) == ScreenSize.mobile;
  static bool isTablet(BuildContext context) =>
      of(context) == ScreenSize.tablet;
  static bool isDesktop(BuildContext context) =>
      of(context) == ScreenSize.desktop;

  static T value<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return switch (of(context)) {
      ScreenSize.mobile => mobile,
      ScreenSize.tablet => tablet ?? mobile,
      ScreenSize.desktop => desktop ?? tablet ?? mobile,
    };
  }

  static double spacing(
    BuildContext context, {
    double mobile = AppSpacing.md,
    double? tablet,
    double? desktop,
  }) {
    return value<double>(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  static int columns(
    BuildContext context, {
    int mobile = 1,
    int? tablet,
    int? desktop,
  }) {
    return value<int>(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}

extension ResponsiveContextExtension on BuildContext {
  ScreenSize get screenSize => Responsive.of(this);

  double get pageSpacing => responsiveSpacing(
    mobile: AppSpacing.md,
    tablet: AppSpacing.lg,
    desktop: AppSpacing.xl,
  );

  EdgeInsets get pagePadding => EdgeInsets.all(pageSpacing);

  double responsiveSpacing({
    double mobile = AppSpacing.md,
    double? tablet,
    double? desktop,
  }) {
    return Responsive.spacing(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
