import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

String responsiveplatform(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    String backgroundAsset;
    
    if (breakpoints.isMobile) {
      backgroundAsset = 'assets/images/';
    } else if (breakpoints.isTablet) {
      backgroundAsset = 'assets/images/';
    } else if (breakpoints.isDesktop) {
      backgroundAsset = 'assets/images/';
    } else {
      backgroundAsset = 'assets/images/';
    }
    return backgroundAsset;
  }