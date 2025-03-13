import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/products/cart/coupon_widget.dart';
import 'package:aurakart/common/widgets/success_screen/success_screen.dart';
import 'package:aurakart/features/shop/controllers/payment_controller.dart';
import 'package:aurakart/features/shop/controllers/product/cart_controller.dart';
import 'package:aurakart/features/shop/controllers/product/checkout_controller.dart';
import 'package:aurakart/features/shop/controllers/product/order_controller.dart';
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
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    final cartController = CartController.instance;
    final paymentController = Get.put(PaymentController());
    final checkoutController = Get.put(CheckoutController());

    return Scaffold(
      // Appbar
      appBar: AAppBar(
        showBackArrow: true,
        title: Text('Order Review',
            style: Theme.of(context).textTheme.headlineSmall),
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
                    SizedBox(height: ASizes.spaceBtwItems / 2),

                    /// Divider
                    Divider(),
                    SizedBox(height: ASizes.spaceBtwItems / 2),

                    /// Payment Methods
                    ABillingPaymentSection(),
                    SizedBox(height: ASizes.spaceBtwItems),

                    Divider(),
                    SizedBox(height: ASizes.spaceBtwItems / 2),

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
        child: Obx(() {
          final subTotal = cartController.totalCartPrice.value;

          final totalAmount =
              APricingCalculator.calculateTotalPrice(subTotal, 'IN');
          final shippingCost =
              APricingCalculator.calculateShippingCost(subTotal, 'IN');
          final taxCost = APricingCalculator.calculateTax(subTotal, 'IN');

          if (subTotal > 0) {
            return ElevatedButton(
              onPressed: () {
                // Get selected payment method
                final selectedMethod =
                    checkoutController.selectedPaymentMethod.value.name;

                paymentController.processPayment(
                    selectedMethod, totalAmount, shippingCost, taxCost);
              },
              child: Text('Checkout  ₹$totalAmount'),
            );
          } else {
            return SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
