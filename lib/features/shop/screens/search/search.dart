import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/layouts/grid_layout.dart';
import 'package:aurakart/common/widgets/products/product-cards/product_card_vertical.dart';
import 'package:aurakart/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:aurakart/features/shop/controllers/search_controller.dart';
import 'package:aurakart/utils/constants/sizes.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(ASizes.sm),
              child: TextField(
                controller: controller.searchTextController,
                onChanged: (query) {
                  controller.searchProducts(query.trim());
                },
                decoration: InputDecoration(
                  hintText: "Search products...",
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Iconsax.close_circle),
                        onPressed: () {
                          controller.searchTextController.clear();
                          controller.searchProducts('');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Obx(
              () => controller.isFetching.value
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: ASizes.sm),
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ),

            // Product grid
            Padding(
              padding: const EdgeInsets.all(ASizes.md),
              child: Obx(
                () {
                  if (controller.isLoading.value) {
                    return const AVerticalProductShimmer();
                  }

                  if (controller.searchTextController.text.trim().isEmpty) {
                    return Center(
                      child: Text(
                        'Search for products',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }

                  if (controller.filteredProducts.isEmpty) {
                    return Center(
                      child: Text(
                        'No Product Found!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }

                  return AGridLayout(
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (_, index) => AProductCardVertical(
                      product: controller.filteredProducts[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
