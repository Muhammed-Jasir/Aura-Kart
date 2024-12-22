import 'package:aurakart/common/widgets/images/rounded_image.dart';
import 'package:aurakart/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:aurakart/common/widgets/texts/product_title_text.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ACartitem extends StatelessWidget {
  const ACartitem({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        /// Image
        ARoundedImage(
          imageUrl: AImages.productImage1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(ASizes.sm),
          backgroundColor: darkMode ? AColors.darkerGrey : AColors.light,
        ),

        const SizedBox(width: ASizes.spaceBtwItems),

        /// Title, Price, & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand Title
              const ABrandTitleWithVerifiedIcon(title: 'Nike'),

              // Product Title
              const Flexible(
                child: AProductTitleText(
                  title: 'Black Sports shoes',
                  maxlines: 1,
                ),
              ),

              /// Attributes
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Color ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: 'Green ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: 'Size ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: 'UK 08',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
