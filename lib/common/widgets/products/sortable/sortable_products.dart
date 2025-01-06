import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:aurakart/common/widgets/layouts/grid_layout.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/common/widgets/products/product-cards/product_card_veritcal.dart';
import 'package:iconsax/iconsax.dart';

class ASortableProducts extends StatelessWidget {
  const ASortableProducts({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {},
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity'
          ]
              .map(
                (option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ),
              )
              .toList(),
        ),

        const SizedBox(height: ASizes.spaceBtwSections),

        /// Products
        AGridLayout(
          itemCount: 8,
          itemBuilder: (_, index) => AProductCardVertical(product: product),
        )
      ],
    );
  }
}
