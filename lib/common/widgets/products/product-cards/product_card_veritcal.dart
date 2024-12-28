import 'package:aurakart/common/styles/shadows.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/icons/circular_icon.dart';
import 'package:aurakart/common/widgets/images/rounded_image.dart';
import 'package:aurakart/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:aurakart/common/widgets/texts/product_price_text.dart';
import 'package:aurakart/common/widgets/texts/product_title_text.dart';
import 'package:aurakart/features/shop/screens/product_details/product_details.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AProductCardVertical extends StatelessWidget {
  const AProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetailScreen()),
      /// Product Card Container
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [AShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(ASizes.productImageRadius),
          color: darkMode ? AColors.darkerGrey : AColors.white,
        ),
        child: Column(
          children: [
            /// Thumbnail, Wishlist Button, Discount Tag
            ARoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(ASizes.sm),
              backgroundColor: darkMode ? AColors.dark : AColors.light,
              child: Stack(
                children: [
                  /// Thumbnail Image
                  const ARoundedImage(
                    imageUrl: AImages.productImage1,
                    applyImageRadius: true,
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

            const SizedBox(height: ASizes.spaceBtwItems / 2),

            ///  Details
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: ASizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    AProductTitleText(
                      title: 'Green Nike Air Shoes',
                      smallSize: true,
                    ),
                
                    SizedBox(height: ASizes.spaceBtwItems / 2),
                
                    // Brand & Verify Icon
                    ABrandTitleWithVerifiedIcon(title: "Nike"),
                  ],
                ),
              ),
            ),

            /// To keep the height of each Box same in case 1 or 2 lines of Headings
            const Spacer(),

            // Price & Add to Cart Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                const Padding(
                  padding: EdgeInsets.only(left: ASizes.sm),
                  child: AProductPriceText(price: '35.0'),
                ),

                /// Add to Cart Button
                Container(
                  decoration: const BoxDecoration(
                    color: AColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ASizes.cardRadiusMd),
                      bottomRight: Radius.circular(ASizes.productImageRadius),
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
    );
  }
}
