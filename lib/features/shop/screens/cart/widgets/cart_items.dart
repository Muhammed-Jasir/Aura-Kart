import 'package:aurakart/common/widgets/products/cart/add_remove_button.dart';
import 'package:aurakart/common/widgets/products/cart/cart_item.dart';
import 'package:aurakart/common/widgets/texts/product_price_text.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ACartItems extends StatelessWidget {
  const ACartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 2,
      shrinkWrap: true,
      separatorBuilder: (_, __) =>
          const SizedBox(height: ASizes.spaceBtwSections),
      itemBuilder: (_, index) => Column(
        children: [
          /// Cart Item
          const ACartitem(),

          if (showAddRemoveButtons)
            const SizedBox(height: ASizes.spaceBtwItems),

          /// Add & Remove Button Row with Total Price
          if (showAddRemoveButtons)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    /// Extra Space
                    SizedBox(width: 70),

                    /// Add & Remove buttons
                    AProductQuantityWithAddRemoveButton(),
                  ],
                ),

                /// Product Total Price
                AProductPriceText(price: '256'),
              ],
            ),
        ],
      ),
    );
  }
}
