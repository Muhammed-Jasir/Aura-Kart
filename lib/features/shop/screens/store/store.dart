import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/appbar/tabbar.dart';
import 'package:aurakart/common/widgets/brands/brand_show_case.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/search_container.dart';
import 'package:aurakart/common/widgets/images/circular_image.dart';
import 'package:aurakart/common/widgets/layouts/grid_layout.dart';
import 'package:aurakart/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:aurakart/common/widgets/shimmers/brands_shimmer.dart';
import 'package:aurakart/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/common/widgets/brands/brand_card.dart';
import 'package:aurakart/features/shop/controllers/brand_controller.dart';
import 'package:aurakart/features/shop/controllers/category_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/screens/brand/all_brands.dart';
import 'package:aurakart/features/shop/screens/brand/brand_products.dart';
import 'package:aurakart/features/shop/screens/cart/cart.dart';
import 'package:aurakart/features/shop/screens/search/search.dart';
import 'package:aurakart/features/shop/screens/store/widgets/category_tab.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    final categories = CategoryController.instance.featuredCategories;

    final brandController = Get.put(BrandController());

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        /// Appbar
        appBar: AAppBar(
          title:
              Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            ACartCouterIcon(
              iconColor: darkMode ? AColors.white : AColors.black,
            ),
          ],
        ),

        /// Header
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxisScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: darkMode ? AColors.black : AColors.white,
                expandedHeight: 440, // Space between Appbar and Tapbar

                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(ASizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: ASizes.spaceBtwItems),

                      /// Search Bar
                      ASearchContainer(
                        text: 'Search in Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                        onTap: () => Get.to(() => const SearchScreen()),
                      ),

                      const SizedBox(height: ASizes.spaceBtwSections),

                      /// Featured Brands
                      ASectionHeading(
                        title: 'Featured Brands',
                        onPressed: () => Get.to(() => const AllBrandsScreen()),
                      ),

                      const SizedBox(height: ASizes.spaceBtwItems / 1.5),

                      /// Brands Grid
                      Obx(
                        () {
                          if (brandController.isLoading.value) {
                            return const ABrandShimmer();
                          }

                          if (brandController.featuredBrands.isEmpty) {
                            return Center(
                              child: Text(
                                'No Data Found!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: Colors.white),
                              ),
                            );
                          }

                          return AGridLayout(
                            itemCount: brandController.featuredBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand =
                                  brandController.featuredBrands[index];
                              return ABrandCard(
                                showBorder: true,
                                brand: brand,
                                onTap: () =>
                                    Get.to(() => BrandProducts(brand: brand)),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),

                /// Tabs
                bottom: ATabBar(
                  tabs: categories
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },

          // Body
          body: TabBarView(
            children: categories
                .map((category) => ACategoryTab(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
