// ignore_for_file: unused_local_variable

import 'package:aurakart/common/widgets/brands/brand_show_case.dart';
import 'package:aurakart/common/widgets/shimmers/boxes_shimmer.dart';
import 'package:aurakart/common/widgets/shimmers/list_tile_shimmer.dart';
import 'package:aurakart/features/shop/controllers/brand_controller.dart';
import 'package:aurakart/features/shop/models/category_model.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({
    super.key,
    required this.category,
  });
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          /// Handle Loader, No Record, OR Error Message
          const loader = Column(
            children: [
              AListTileShimmer(),
              SizedBox(height: ASizes.spaceBtwItems),
              ABoxesShimmer(),
              SizedBox(
                height: ASizes.spaceBtwItems,
              )
            ],
          );

          final Widget = ACloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (Widget != null) return Widget;

          /// Record Found!

          final brands = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            itemBuilder: (_, index) {
              final brand = brands[index];
              return FutureBuilder(
                  future:
                      controller.getBrandProducts(brandId: brand.id, limit: 3),
                  builder: (context, snapshot) {
                    /// Handle Loader ,No Record, Or Error Message
                    final widget = ACloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    /// Record Found!
                    final products = snapshot.data;
                    return ABrandShowcase(
                      brand: brand,
                      images: products.map((e) => e.thumbnail).toList(),
                    );
                  });
            },
          );
        });
  }
}
