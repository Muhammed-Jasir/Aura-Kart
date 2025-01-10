import 'package:aurakart/features/shop/controllers/cart_controller.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class ABillingAmountSection extends StatelessWidget {
  const ABillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;

    return Column(
      children: [
        /// Sub-Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$$subTotal', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),

        const SizedBox(height: ASizes.spaceBtwItems / 2),

        /// Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text(
                '\$${APricingCalculator.calculateShippingCost(subTotal, 'US')}',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),

        const SizedBox(height: ASizes.spaceBtwItems / 2),

        /// Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${APricingCalculator.calculateTax(subTotal, 'US')}',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('₹6.0', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),

        const SizedBox(height: ASizes.spaceBtwItems / 2),

        /// Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${APricingCalculator.calculateTotalPrice(subTotal, 'US')}',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
