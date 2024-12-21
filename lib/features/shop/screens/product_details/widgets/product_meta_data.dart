import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/images/circular_image.dart';
import 'package:aurakart/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:aurakart/common/widgets/texts/product_price_text.dart';
import 'package:aurakart/common/widgets/texts/product_title_text.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AProductMetaData extends StatelessWidget {
  const AProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Sale Tag
            ARoundedContainer(
              radius: ASizes.sm,
              backgroundColor: AColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: ASizes.sm, vertical: ASizes.xs),
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: AColors.black),
              ),
            ),

            const SizedBox(width: ASizes.spaceBtwItems),

            /// Old Price
            Text(
              '₹250',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),

            const SizedBox(width: ASizes.spaceBtwItems),

            // New Price
            const AProductPriceText(price: '175', isLarge: true),
          ],
        ),

        const SizedBox(height: ASizes.spaceBtwItems / 1.5),

        /// Product Title
        const AProductTitleText(title: 'Green Nike Sports Shirt'),
        const SizedBox(height: ASizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            const AProductTitleText(title: 'Status:'),
            const SizedBox(width: ASizes.spaceBtwItems),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),

        const SizedBox(height: ASizes.spaceBtwItems / 1.5),

        /// Brand
        Row(
          children: [
            // Brand Icon
            ACircularImage(
              image: AImages.shoeIcon,
              width: 32,
              height: 32,
              overLayColor: darkMode ? AColors.white : AColors.black,
            ),

            const SizedBox(width: ASizes.spaceBtwItems / 4),

            const ABrandTitleWithVerifiedIcon(
              title: 'Nike',
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
