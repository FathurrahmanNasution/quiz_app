import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= 600 && w < 1200;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double getMaxWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 600;
    return 1000;
  }

  static EdgeInsets getHorizontalPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (isMobile(context)) {
      return EdgeInsets.symmetric(horizontal: screenWidth * 0.06);
    } else if (isTablet(context)) {
      return EdgeInsets.symmetric(horizontal: screenWidth * 0.08);
    } else {
      return EdgeInsets.symmetric(horizontal: screenWidth * 0.12);
    }
  }

  /// Returns a scaled font multiplier. Provide the base mobile size as input.
  static double getFontSize(BuildContext context, double mobileSize) {
    if (isMobile(context)) return mobileSize;
    if (isTablet(context)) return mobileSize * 1.15;
    return mobileSize * 1.3;
  }

  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context) && desktop != null) {
      return desktop!;
    } else if (ResponsiveHelper.isTablet(context) && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}