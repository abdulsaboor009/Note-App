import 'package:flutter/material.dart';
import '../../utils/constants/responsive_sizes.dart';

extension SizedBoxExtension on num {
  SizedBox get height => SizedBox(
        height: ResponsiveSize.h * this,
      );

  SizedBox get width => SizedBox(
        width: ResponsiveSize.w * this,
      );
}
