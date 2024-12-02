import 'package:aurakart/common/widgets/brands/brand_show_case.dart';
import 'package:aurakart/common/widgets/layouts/grid_layout.dart';
import 'package:aurakart/common/widgets/products/product-cards/product_card_veritcal.dart';
import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Brands
              const TBrandShowcase(
                images: [
                  TImages.productImage10,
                  TImages.productImage11,
                  TImages.productImage16
                ],
              ),

              const TBrandShowcase(
                images: [
                  TImages.productImage10,
                  TImages.productImage11,
                  TImages.productImage16
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              // Products
              TSectionHeading(
                title: 'You might like',
                showActionbutton: true,
                onPressed: () {},
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              TGridLayout(
                itemCount: 4,
                itemBuilder: (_, index) => const TProductCardVertical(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
