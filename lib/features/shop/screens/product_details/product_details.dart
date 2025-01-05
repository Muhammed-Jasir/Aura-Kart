import 'package:aurakart/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:aurakart/common/widgets/images/rounded_image.dart';
import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/screens/checkout/checkout.dart';
import 'package:aurakart/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:aurakart/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:aurakart/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:aurakart/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:aurakart/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:aurakart/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ABottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Product Image Slider
            const AProductImageSlider(),

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
                  const ARatingAndShare(),

                  /// Price, Title, Stack, & Brand
                  const AProductMetaData(),
                  const SizedBox(height: ASizes.spaceBtwItems),

                  /// Attributes
                  const AProductAttributes(),
                  const SizedBox(height: ASizes.spaceBtwSections),

                  /// Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const CheckoutScreen()),
                      child: const Text('Checkout'),
                    ),
                  ),

                  const SizedBox(height: ASizes.spaceBtwSections),

                  /// Description
                  const ASectionHeading(
                    title: "Description",
                    showActionbutton: false,
                  ),

                  const SizedBox(height: ASizes.spaceBtwItems),

                  const ReadMoreText(
                    'This is a product description for Blue Nike Sleeve less vest. There are more things that can be added. This is a product description for Blue Nike Sleeve less vest. There are more things that can be added',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' more',
                    trimExpandedText: ' less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  const SizedBox(height: ASizes.spaceBtwItems),
                  const Divider(),
                  const SizedBox(height: ASizes.spaceBtwItems),

                  /// Reviews
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title
                      const ASectionHeading(
                        title: 'Reviews (99)',
                        showActionbutton: false,
                      ),

                      // Arrow Button
                      IconButton(
                        icon: const Icon(
                          Iconsax.arrow_right_3,
                          size: 18,
                        ),
                        onPressed: () =>
                            Get.to(() => const ProductReviewsScreens()),
                      ),
                    ],
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
