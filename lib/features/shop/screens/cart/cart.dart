import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/products/cart/add_remove_button.dart';
import 'package:aurakart/common/widgets/products/cart/cart_item.dart';
import 'package:aurakart/common/widgets/texts/product_price_text.dart';
import 'package:aurakart/features/shop/controllers/product/cart_controller.dart';
import 'package:aurakart/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:aurakart/features/shop/screens/checkout/checkout.dart';
import 'package:aurakart/navigation_menu.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/loaders/animation_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      // Appbar
      appBar: AAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),

      // Body
      body: Obx(
        () {
          /// Nothing found Widget
          final emptyWidget = AAnimationLoaderWidget(
            text: 'Whoops! Cart is Empty',
            animation: AImages.cartAnimation,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );

          return controller.cartItems.isEmpty
              ? emptyWidget
              : const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(ASizes.defaultSpace),

                    /// Items in Cart
                    child: ACartItems(),
                  ),
                );
        },
      ),

      /// Checkout Button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Obx(
                  () => Text('Checkout ₹${controller.totalCartPrice.value}'),
                ),
              ),
            ),
    );
  }
}
