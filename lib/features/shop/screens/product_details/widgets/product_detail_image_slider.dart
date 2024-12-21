import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:aurakart/common/widgets/icons/circular_icon.dart';
import 'package:aurakart/common/widgets/images/rounded_image.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AProductImageSlider extends StatelessWidget {
  const AProductImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    return ACurvedEdgesWidget(
      child: Container(
        color: darkMode ? AColors.darkerGrey : AColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            const SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(ASizes.productImageRadius * 2),
                child: Center(
                  child: Image(image: AssetImage(AImages.productImage1)),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: ASizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: ASizes.spaceBtwItems),
                  itemBuilder: (_, index) => ARoundedImage(
                    width: 80,
                    backgroundColor: darkMode ? AColors.dark : AColors.white,
                    border: Border.all(color: AColors.primary),
                    padding: const EdgeInsets.all(ASizes.sm),
                    imageUrl: AImages.productImage22,
                  ),
                ),
              ),
            ),

            /// Appbar Icons
            const AAppBar(
              showBackArrow: true,
              actions: [
                ACircularIcon(icon: Iconsax.heart5, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
