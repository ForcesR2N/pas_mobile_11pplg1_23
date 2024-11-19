import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  const Responsive(
      {super.key, required this.mobile, this.tablet, this.desktop});

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1900;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1900;
  
  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1900) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= 768) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

extension ResponsiveSize on BuildContext {
  double get spacing => Responsive.isLandscape(this)
      ? (Responsive.isMobile(this) ? 12.0 : 16.0)
      : (Responsive.isMobile(this) ? 16.0 : 24.0);

  double get radius => Responsive.isLandscape(this)
      ? (Responsive.isMobile(this) ? 12.0 : 15.0)
      : (Responsive.isMobile(this) ? 15.0 : 20.0);

  double get iconSize => Responsive.isLandscape(this)
      ? (Responsive.isMobile(this) ? 20.0 : 24.0)
      : (Responsive.isMobile(this) ? 24.0 : 28.0);

  double get fontSize => Responsive.isLandscape(this)
      ? (Responsive.isMobile(this) ? 14.0 : 16.0)
      : (Responsive.isMobile(this) ? 16.0 : 18.0);
}