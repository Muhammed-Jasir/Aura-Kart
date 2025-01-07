import 'package:aurakart/common/widgets/products/sortable/sortable_products.dart';
import 'package:aurakart/common/widgets/shimmers/brands_shimmer.dart';
import 'package:aurakart/features/shop/controllers/brand_controller.dart';
import 'package:aurakart/features/shop/models/brand_model.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/screens/brand/brand_products.dart';
import 'package:flutter/material.dart';
import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/common/widgets/layouts/grid_layout.dart';
import 'package:aurakart/common/widgets/brands/brand_card.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;

    return Scaffold(
      // Appbar
      appBar: const AAppBar(title: Text('Brand'), showBackArrow: true),
      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              const ASectionHeading(title: 'Brands', showActionbutton: false),
              const SizedBox(height: ASizes.spaceBtwItems),

              Obx(
                () {
                  if (brandController.isLoading.value) {
                    return const ABrandShimmer();
                  }

                  if (brandController.allBrands.isEmpty) {
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
                    itemCount: brandController.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final brand = brandController.allBrands[index];
                      return ABrandCard(
                        showBorder: false,
                        brand: brand,
                        onTap: () => Get.to(() => BrandProducts(brand: brand)),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
