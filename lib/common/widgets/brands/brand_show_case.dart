import 'package:aurakart/common/widgets/brands/brand_card.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ABrandShowcase extends StatelessWidget {
  const ABrandShowcase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      showBorder: true,
      borderColor: AColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(ASizes.md),
      margin: const EdgeInsets.only(bottom: ASizes.spaceBtwItems),
      child: Column(
        children: [
          // Brands with Product Count
          const ABrandCard(showBorder: false),
          const SizedBox(height: ASizes.spaceBtwItems),
          
          // Brand Top 3 Product Images
          Row(
            children: images
                .map((image) => brandTopProductImageWidget(image, context))
                .toList(),
          ),
        ],
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context) {
  return Expanded(
    child: ARoundedContainer(
      height: 100,
      backgroundColor: AHelperFunctions.isDarkMode(context)
          ? AColors.darkerGrey
          : AColors.grey,
      margin: const EdgeInsets.only(right: ASizes.sm),
      padding: const EdgeInsets.all(ASizes.md),
      child: Image(
        image: AssetImage(image),
        fit: BoxFit.contain,
      ),
    ),
  );
}
