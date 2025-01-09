import 'package:aurakart/common/widgets/shimmers/shimmer.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AHorizontalProductShimmer extends StatelessWidget {
 const AHorizontalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ASizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) =>
            const SizedBox(width: ASizes.spaceBtwItems),
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Image

            AShimmerEffect(width: 120, height: 126),
            SizedBox(width: ASizes.spaceBtwItems),

            /// Text

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: ASizes.spaceBtwItems / 2),
                AShimmerEffect(width: 160, height: 15),
                SizedBox(height: ASizes.spaceBtwItems / 2),
                AShimmerEffect(width: 110, height: 15),
                SizedBox(height: ASizes.spaceBtwItems / 2),
                AShimmerEffect(width: 88, height: 15),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
