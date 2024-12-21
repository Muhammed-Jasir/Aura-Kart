import 'package:aurakart/common/widgets/icons/circular_icon.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AProductQuantityWithAddRemoveButton extends StatelessWidget {
  const AProductQuantityWithAddRemoveButton({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Minus Icon
        ACircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: ASizes.md,
          color: darkMode ? AColors.white : AColors.black,
          backgroundColor: darkMode ? AColors.darkerGrey : AColors.light,
        ),

        const SizedBox(width: ASizes.spaceBtwItems),
        // Cart Quantity
        Text('12', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: ASizes.spaceBtwItems),

        // Plus Icon
        const ACircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: ASizes.md,
          color: AColors.white,
          backgroundColor: AColors.primary,
        ),
      ],
    );
  }
}
