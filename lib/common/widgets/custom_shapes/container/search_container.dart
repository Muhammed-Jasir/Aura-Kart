import 'package:aurakart/main.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/device/device_utility.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ASearchContainer extends StatelessWidget {
  const ASearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: ASizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: ADeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(ASizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? darkMode
                    ? AColors.dark
                    : AColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(ASizes.cardRadiusLg),
            border: showBorder
                ? Border.all(
                    color: darkMode ? AColors.darkerGrey : AColors.grey,
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: AColors.darkGrey),
              const SizedBox(width: ASizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
