import 'package:aurakart/common/widgets/products/cart/add_remove_button.dart';
import 'package:aurakart/common/widgets/products/cart/cart_item.dart';
import 'package:aurakart/common/widgets/texts/product_price_text.dart';
import 'package:aurakart/features/shop/controllers/product/cart_controller.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ACartItems extends StatelessWidget {
  const ACartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Obx(
      () => ListView.separated(
        itemCount: controller.cartItems.length,
        shrinkWrap: true,
        separatorBuilder: (_, __) =>
            const SizedBox(height: ASizes.spaceBtwSections),
        itemBuilder: (_, index) => Obx(
          () {
            final item = controller.cartItems[index];
            
            return Column(
              children: [
                /// Cart Item
                ACartitem(cartItem: item),

                if (showAddRemoveButtons)
                  const SizedBox(height: ASizes.spaceBtwItems),

                /// Add & Remove Button Row with Total Price
                if (showAddRemoveButtons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          /// Extra Space
                          const SizedBox(width: 70),

                          /// Add & Remove buttons
                          AProductQuantityWithAddRemoveButton(
                            quantity: item.quantity,
                            add: () => controller.addOneToCart(item),
                            remove: () => controller.removeOneFromCart(item),
                          ),
                        ],
                      ),

                      /// Product Total Price
                      AProductPriceText(
                        price: (item.price * item.quantity).toStringAsFixed(1),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
