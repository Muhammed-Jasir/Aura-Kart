import "package:aurakart/common/widgets/appbar/appbar.dart";
import "package:aurakart/common/widgets/custom_shapes/container/circular_container.dart";
import "package:aurakart/common/widgets/custom_shapes/container/primary_header_container.dart";
import "package:aurakart/common/widgets/custom_shapes/container/search_container.dart";
import "package:aurakart/common/widgets/layouts/grid_layout.dart";
import "package:aurakart/common/widgets/products/cart/cart_menu_icon.dart";
import "package:aurakart/common/widgets/products/product-cards/product_card_veritcal.dart";
import "package:aurakart/common/widgets/shimmers/vertical_product_shimmer.dart";
import "package:aurakart/common/widgets/texts/section_heading.dart";
import "package:aurakart/features/chatbot/screen/chatbot_button.dart";
import "package:aurakart/features/shop/controllers/product/product_controller.dart";
import "package:aurakart/features/shop/models/product_model.dart";
import "package:aurakart/features/shop/screens/all_products/all_products.dart";
import "package:aurakart/features/shop/screens/home/widgets/home_appbar.dart";
import "package:aurakart/features/shop/screens/home/widgets/home_categories.dart";
import "package:aurakart/features/shop/screens/home/widgets/promo_slider.dart";
import "package:aurakart/utils/constants/colors.dart";
import "package:aurakart/utils/constants/image_strings.dart";
import "package:aurakart/utils/constants/sizes.dart";
import "package:aurakart/utils/constants/text_strings.dart";
import "package:aurakart/utils/device/device_utility.dart";
import "package:aurakart/utils/helpers/helper_functions.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iconsax/iconsax.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                /// Header
                const APrimaryHeaderContainer(
                  child: Column(
                    children: [
                      // Appbar
                      AHomeAppbar(),
                      SizedBox(height: ASizes.spaceBtwSections),

                      // Searchbar
                      ASearchContainer(text: 'Search in Store'),
                      SizedBox(height: ASizes.spaceBtwSections),

                      // Category Section
                      Padding(
                        padding: EdgeInsets.only(
                          left: ASizes.defaultSpace,
                          right: ASizes.defaultSpace,
                        ),
                        child: Column(
                          children: [
                            /// Heading
                            ASectionHeading(
                              title: 'Popular Categories',
                              showActionbutton: false,
                              textColor: AColors.white,
                            ),

                            SizedBox(height: ASizes.spaceBtwItems),

                            /// Categories
                            AHomeCategories(),
                          ],
                        ),
                      ),

                      SizedBox(height: ASizes.spaceBtwSections),
                    ],
                  ),
                ),

                /// Body
                Padding(
                  padding: const EdgeInsets.all(ASizes.defaultSpace),
                  child: Column(
                    children: [
                      // Banner Promo Slider
                      const APromoSlider(),

                      const SizedBox(height: ASizes.spaceBtwSections),

                      /// Product Heading
                      ASectionHeading(
                        title: 'Popular Products',
                        onPressed: () => Get.to(
                          () => AllProducts(
                            title: 'Popular Products',
                            futureMethod: controller.fetchAllFeaturedProducts(),
                          ),
                        ),
                      ),

                      const SizedBox(height: ASizes.spaceBtwItems),

                      /// Popular Products
                      Obx(
                        () {
                          if (controller.isLoading.value) {
                            return const AVerticalProductShimmer();
                          }

                          if (controller.featuredProducts.isEmpty) {
                            return Center(
                              child: Text(
                                'No Data Found!',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }

                          return AGridLayout(
                            itemCount: controller.featuredProducts.length,
                            itemBuilder: (_, index) => AProductCardVertical(
                              product: controller.featuredProducts[index],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ), // Chatbot Button
          const Positioned(
            bottom: 16,
            right: 16,
            child: ChatButton(),
          ),
        ],
      ),
    );
  }
}
