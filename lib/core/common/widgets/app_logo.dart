import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_assets.dart';

/// CraftyBay branded SVG logo.
///
/// Usage:
/// ```dart
/// AppLogo()                      // default 120 px wide
/// AppLogo(width: 80)             // smaller variant (e.g. AppBar)
/// AppLogo(width: 120, height: 120)
/// ```
class AppLogo extends StatelessWidget {
  final double width;
  final double? height;
  final BoxFit fit;

  const AppLogo({
    super.key,
    this.width = 120,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.appLogo,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
