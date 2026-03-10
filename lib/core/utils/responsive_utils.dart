import 'package:flutter/material.dart';

class ResponsiveUtils {
  static late MediaQueryData _queryData;
  static late double screenWidth;
  static late double screenHeight;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static late double devicePixelRatio;
  static late double textScaleFactor;

  void init(BuildContext context) {
    _queryData = MediaQuery.of(context);
    screenWidth = _queryData.size.width;
    screenHeight = _queryData.size.height;
    devicePixelRatio = _queryData.devicePixelRatio;
    textScaleFactor = _queryData.textScaleFactor;

    _safeAreaHorizontal = _queryData.padding.left + _queryData.padding.right;
    _safeAreaVertical = _queryData.padding.top + _queryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  // Breakpoints
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  // Adaptive scaling
  // Base designs are often done for a 375x812 (iPhone X/12) size
  // ── Scaling Methods ──
  static double scaleWidth(BuildContext context, double val) =>
      (MediaQuery.of(context).size.width / 375.0) * val;

  static double scaleHeight(BuildContext context, double val) =>
      (MediaQuery.of(context).size.height / 812.0) * val;

  static double scaleText(BuildContext context, double val) {
    final double scale = MediaQuery.of(context).size.width / 375.0;
    return val * (scale > 1.2 ? 1.2 : scale);
  }
}

// ── BuildContext Extension for easy access ──
extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  // Scaled dimensions
  double w(double val) => ResponsiveUtils.scaleWidth(this, val);
  double h(double val) => ResponsiveUtils.scaleHeight(this, val);
  double sp(double val) => ResponsiveUtils.scaleText(this, val);

  // Spacing helpers
  EdgeInsets get paddingAll => EdgeInsets.all(w(16));
  EdgeInsets get paddingHorizontal => EdgeInsets.symmetric(horizontal: w(16));
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: h(16));
}
