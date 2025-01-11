import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/products/cart/coupon_widget.dart';
import 'package:aurakart/common/widgets/success_screen/success_screen.dart';
import 'package:aurakart/features/shop/controllers/cart_controller.dart';
import 'package:aurakart/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:aurakart/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:aurakart/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:aurakart/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:aurakart/navigation_menu.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:aurakart/utils/helpers/pricing_calculator.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = CartController.totalCartPrice.value;
    final darkMode = AHelperFunctions.isDarkMode(context);
    final orderController = Get.put(OrderController());
    final totalAmount = APricingCalculator.calculateTotalPrice(subTotal, 'US');

    return Scaffold(
      // Appbar
      appBar: AAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// Items in Cart
              const ACartItems(showAddRemoveButtons: false),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// Coupon TextField
              const ACouponCode(),
              const SizedBox(height: ASizes.spaceBtwItems),

              /// Billing Section
              ARoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(ASizes.md),
                backgroundColor: darkMode ? AColors.black : AColors.white,
                child: const Column(
                  children: [
                    /// Pricing
                    ABillingAmountSection(),
                    SizedBox(height: ASizes.spaceBtwItems),

                    /// Divider
                    Divider(),
                    SizedBox(height: ASizes.spaceBtwItems),

                    /// Payment Methods
                    ABillingPaymentSection(),
                    SizedBox(height: ASizes.spaceBtwItems),

                    /// Address
                    ABillingAddressSection(),
                    SizedBox(height: ASizes.spaceBtwItems),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => ALoaders.warningSnackBar(
                  title: 'Empty Cart',
                  message: 'Add items in the cart in order to proceed'),
          child: Text('Checkout \$$totalAmount'),
        ),
      ),
    );
  }
}
