import 'package:aurakart/common/widgets/icons/circular_icon.dart';
import 'package:aurakart/features/shop/screens/cart/cart.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ABottomAddToCart extends StatelessWidget {
  const ABottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ASizes.defaultSpace,
        vertical: ASizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: darkMode ? AColors.darkerGrey : AColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(ASizes.cardRadiusLg),
          topRight: Radius.circular(ASizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Change Product Count Button
          Row(
            children: [
              // Minus Icon
              const ACircularIcon(
                icon: Iconsax.minus,
                backgroundColor: AColors.darkGrey,
                width: 40,
                height: 40,
                color: AColors.white,
              ),

              const SizedBox(width: ASizes.spaceBtwItems),

              // Count
              Text("2", style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: ASizes.spaceBtwItems),

              // Add Icon
              const ACircularIcon(
                icon: Iconsax.add,
                backgroundColor: AColors.black,
                width: 40,
                height: 40,
                color: AColors.white,
              ),
            ],
          ),

          // Add to Cart Button
          ElevatedButton(
            onPressed: () => Get.to(() => const CartScreen()),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(ASizes.md),
              backgroundColor: AColors.black,
              side: const BorderSide(color: AColors.black),
            ),
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
