import 'package:aurakart/common/widgets/shimmers/shimmer.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AListTileShimmer extends StatelessWidget {
  const AListTileShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            AShimmerEffect(width: 58, height: 56, radius: 58),
            SizedBox(width: ASizes.spaceBtwItems),
            Column(
              children: [
                AShimmerEffect(width: 100, height: 15),
                SizedBox(height: ASizes.spaceBtwItems / 2),
                AShimmerEffect(width: 80, height: 12),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
