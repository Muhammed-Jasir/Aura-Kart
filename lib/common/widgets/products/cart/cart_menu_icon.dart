import 'package:aurakart/features/shop/screens/cart/cart.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ACartCouterIcon extends StatelessWidget {
  const ACartCouterIcon({
    super.key,
    required this.onPressed,
    required this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });

  final VoidCallback onPressed;
  final Color iconColor;
  final Color? counterBgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);
    
    return Stack(
      children: [
        // Cart Icon
        IconButton(
          onPressed: onPressed,
          icon: Icon(Iconsax.shopping_bag, color: iconColor),
        ),

        // Cart Count Text
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color:
                  counterBgColor ?? (darkMode ? AColors.white : AColors.black),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: counterTextColor ?? (darkMode ? AColors.black : AColors.white) , fontSizeFactor: 0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
