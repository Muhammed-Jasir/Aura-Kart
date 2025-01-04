import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AShimmerEffect extends StatelessWidget {
  const AShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  });

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Shimmer.fromColors(
      baseColor: darkMode ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: darkMode ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (darkMode ? AColors.darkerGrey : AColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
