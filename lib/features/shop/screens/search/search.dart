import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/images/circular_image.dart';
import 'package:aurakart/common/widgets/layouts/grid_layout.dart';
import 'package:aurakart/common/widgets/products/product-cards/product_card_veritcal.dart';
import 'package:aurakart/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:aurakart/features/shop/controllers/search_controller.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchProductController());

    return Scaffold(
      appBar: AAppBar(title: const Text('Search'), showBackArrow: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(ASizes.sm),
            child: TextField(
              controller: controller.searchTextController,
              onChanged: (query) {
                controller.searchProducts(query);
              },
              decoration: InputDecoration(
                hintText: "Search products...",
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Iconsax.search_normal),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Iconsax.close_circle),
                      onPressed: () {
                        controller.searchTextController.clear();
                        controller.searchProducts('');
                      },
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? const Padding(
                              padding: EdgeInsets.all(ASizes.md),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Product grid
          Expanded(
            child: Obx(
              () {
                final results = controller.filteredProducts;
                return results.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.search_normal,
                                size: 50, color: Colors.grey),
                            const SizedBox(height: ASizes.spaceBtwItems),
                            Text("No products found",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      )
                    : AGridLayout(
                        itemCount: results.length,
                        itemBuilder: (_, index) {
                          final product = results[index];
                          return AProductCardVertical(product: product);
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
