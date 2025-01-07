import 'package:aurakart/features/shop/controllers/all_products_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:aurakart/common/widgets/layouts/grid_layout.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/common/widgets/products/product-cards/product_card_veritcal.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class ASortableProducts extends StatelessWidget {
  const ASortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product sorting
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectSortOption.value,
          onChanged: (value) {
            controller.sortProducts('value!');
          },
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
        Obx(
          () => AGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>
                AProductCardVertical(product: controller.products[index]),
          ),
        )
      ],
    );
  }
}
