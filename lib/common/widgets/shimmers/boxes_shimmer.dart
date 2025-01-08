import 'package:aurakart/common/widgets/shimmers/shimmer.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ABoxesShimmer extends StatelessWidget {
  const ABoxesShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: AShimmerEffect(width: 150, height: 118)),
            SizedBox(width: ASizes.spaceBtwItems),
            Expanded(child: AShimmerEffect(width: 150, height: 110)),
            SizedBox(width: ASizes.spaceBtwItems),
            Expanded(child: AShimmerEffect(width: 150, height: 110)),
          ],
        )
      ],
    );
  }
}
