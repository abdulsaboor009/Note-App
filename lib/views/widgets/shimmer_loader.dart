import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/constants/app_colors.dart';

class ShimmerEffectLoader extends StatelessWidget {
  final double width, height, radius;
  const ShimmerEffectLoader({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[900]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
