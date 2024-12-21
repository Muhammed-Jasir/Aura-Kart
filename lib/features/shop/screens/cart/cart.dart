import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/products/cart/add_remove_button.dart';
import 'package:aurakart/common/widgets/products/cart/cart_item.dart';
import 'package:aurakart/common/widgets/texts/product_price_text.dart';
import 'package:aurakart/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:aurakart/features/shop/screens/checkout/checkout.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),

      // Body
      body: const Padding(
        padding: EdgeInsets.all(ASizes.defaultSpace),
        /// Items in Cart
        child: ACartItems()
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => const CheckoutScreen()),
          child: const Text('Checkout ₹256.0'),
        ),
      ),
    );
  }
}
