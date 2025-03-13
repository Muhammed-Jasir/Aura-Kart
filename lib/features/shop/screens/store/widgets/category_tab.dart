import 'package:aurakart/common/widgets/brands/brand_show_case.dart';
import 'package:aurakart/common/widgets/layouts/grid_layout.dart';
import 'package:aurakart/common/widgets/products/product-cards/product_card_veritcal.dart';
import 'package:aurakart/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/features/shop/controllers/category_controller.dart';
import 'package:aurakart/features/shop/models/category_model.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/screens/store/widgets/category_brands.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import "package:aurakart/features/shop/screens/all_products/all_products.dart";
import "package:get/get.dart";

class ACategoryTab extends StatelessWidget {
  const ACategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              // Brands
              CategoryBrands(category: category),
              const SizedBox(height: ASizes.spaceBtwItems),

              // Products
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  /// Helper Function :Handle Loder , No Record, OR ERROR Message
                  final response = ACloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: const AVerticalProductShimmer(),
                  );

                  if (response != null) return response;

                  /// Record Found!
                  final products = snapshot.data!;

                  return Column(
                    children: [
                      ASectionHeading(
                        title: 'Recommended for you',
                        showActionbutton: true,
                        onPressed: () => Get.to(
                          () => AllProducts(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(
                              categoryId: category.id,
                              limit: -1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: ASizes.spaceBtwItems),
                      AGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) =>
                            AProductCardVertical(product: products[index]),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
