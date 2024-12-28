import 'package:aurakart/common/styles/shadows.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/icons/circular_icon.dart';
import 'package:aurakart/common/widgets/images/rounded_image.dart';
import 'package:aurakart/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:aurakart/common/widgets/texts/product_price_text.dart';
import 'package:aurakart/common/widgets/texts/product_title_text.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AProductHorizontal extends StatelessWidget {
  const AProductHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ASizes.productImageRadius),
        color: darkMode ? AColors.darkerGrey : AColors.softGrey,
      ),
      child: Row(
        children: [
          /// Thumbnail
          ARoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(ASizes.sm),
            backgroundColor: darkMode ? AColors.dark : AColors.light,
            child: Stack(
              children: [
                /// Thumbnail Image
                const SizedBox(
                  height: 120,
                  width: 120,
                  child: ARoundedImage(
                    imageUrl: AImages.productImage1,
                    applyImageRadius: true,
                  ),
                ),

                /// Sale Tag
                Positioned(
                  top: 12,
                  child: ARoundedContainer(
                    radius: ASizes.sm,
                    backgroundColor: AColors.secondary.withValues(alpha: 0.8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: ASizes.sm,
                      vertical: ASizes.xs,
                    ),
                    child: Text(
                      '25%',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: AColors.black),
                    ),
                  ),
                ),

                /// Favourite Icon Button
                const Positioned(
                  top: 0,
                  right: 0,
                  child: ACircularIcon(
                    icon: Iconsax.heart5,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          /// Details
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(left: ASizes.sm, top:ASizes.sm),
              child: Column(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AProductTitleText(
                        title: 'Green Nike Half Sleeves Shirt',
                        smallSize: true,
                      ),
                      SizedBox(height: ASizes.spaceBtwItems / 2),
                      ABrandTitleWithVerifiedIcon(title: 'Nike'),
                    ],
                  ),
              
                  const Spacer(),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Price
                      const Flexible(child: AProductPriceText(price: '256.0')),
              
                      /// Add to Cart Button
                      Container(
                        decoration: const BoxDecoration(
                          color: AColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ASizes.cardRadiusMd),
                            bottomRight:
                                Radius.circular(ASizes.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                          width: ASizes.iconLg * 1.2,
                          height: ASizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(Iconsax.add, color: AColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
