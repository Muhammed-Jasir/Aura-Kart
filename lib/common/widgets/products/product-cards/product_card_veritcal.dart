import 'package:aurakart/common/styles/shadows.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/icons/circular_icon.dart';
import 'package:aurakart/common/widgets/images/rounded_image.dart';
import 'package:aurakart/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:aurakart/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:aurakart/common/widgets/texts/product_price_text.dart';
import 'package:aurakart/common/widgets/texts/product_title_text.dart';
import 'package:aurakart/features/shop/controllers/product/product_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/models/product_variation_model.dart';
import 'package:aurakart/features/shop/screens/product_details/product_details.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AProductCardVertical extends StatelessWidget {
  const AProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;

    final salePercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );

    final darkMode = AHelperFunctions.isDarkMode(context);

    // Container with side paddings, color, edges, radius and shadow
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),

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
              width: 180,
              padding: const EdgeInsets.all(ASizes.sm),
              backgroundColor: darkMode ? AColors.dark : AColors.light,
              child: Stack(
                children: [
                  /// Thumbnail Image
                  Center(
                    child: ARoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  /// Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: ARoundedContainer(
                        radius: ASizes.sm,
                        backgroundColor:
                            AColors.secondary.withValues(alpha: 0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: ASizes.sm,
                          vertical: ASizes.xs,
                        ),
                        child: Text(
                          '$salePercentage%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: AColors.black),
                        ),
                      ),
                    ),

                  /// Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: AFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),

            const SizedBox(height: ASizes.spaceBtwItems / 2),

            ///  Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: ASizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    AProductTitleText(title: product.title, smallSize: true),

                    const SizedBox(height: ASizes.spaceBtwItems / 2),

                    // Brand & Verify Icon
                    ABrandTitleWithVerifiedIcon(title: product.brand!.name),
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
                Flexible(
                  child: Column(
                    children: [
                      if (product.productType ==
                              ProductType.single.toString() &&
                          product.salePrice > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: ASizes.sm),
                          child: Text(
                            product.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        ),

                      /// Price, Show sale price as main price if sale exist
                      Padding(
                        padding: const EdgeInsets.only(left: ASizes.sm),
                        child: AProductPriceText(
                          price: controller.getProductPrice(product),
                        ),
                      ),
                    ],
                  ),
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
