import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:aurakart/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:aurakart/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:aurakart/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:aurakart/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:aurakart/features/shop/controllers/review/review_controller.dart';
import 'package:aurakart/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:aurakart/utils/formatters/formatter.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final reviewController = ReviewController.getOrPut(product);

    return Scaffold(
      bottomNavigationBar: ABottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Product Image Slider
            AProductImageSlider(product: product),

            /// Product Details
            Padding(
              padding: const EdgeInsets.only(
                right: ASizes.defaultSpace,
                left: ASizes.defaultSpace,
                bottom: ASizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// Rating & Share Button
                  ARatingAndShare(product: product),

                  /// Price, Title, Stack, & Brand
                  AProductMetaData(product: product),
                  const SizedBox(height: ASizes.spaceBtwItems),

                  /// Attributes
                  if (product.productType == ProductType.variable.toString())
                    AProductAttributes(product: product),

                  if (product.productType == ProductType.variable.toString())
                    const SizedBox(height: ASizes.spaceBtwSections),


                  /// Description
                  const ASectionHeading(
                      title: "Description", showActionbutton: false),

                  const SizedBox(height: ASizes.spaceBtwItems),

                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  const SizedBox(height: ASizes.spaceBtwItems),
                  const Divider(),
                  const SizedBox(height: ASizes.spaceBtwItems),

                  /// Reviews
                  Obx(
                    () {
                      final reviewCount =
                          reviewController.stats.value.totalReviews;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ASectionHeading(
                            title:
                                'Reviews (${AFormatter.formatCount(reviewCount)})',
                            showActionbutton: false,
                          ),
                          IconButton(
                            icon: const Icon(Iconsax.arrow_right_3, size: 18),
                            onPressed: () => Get.to(
                              () => ProductReviewsScreens(product: product),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: ASizes.spaceBtwItems),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
