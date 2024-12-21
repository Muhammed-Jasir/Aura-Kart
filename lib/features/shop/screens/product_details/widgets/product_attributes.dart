import 'package:aurakart/common/widgets/chips/choice_chips.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/texts/product_price_text.dart';
import 'package:aurakart/common/widgets/texts/product_title_text.dart';
import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AProductAttributes extends StatelessWidget {
  const AProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        // Selected Attribute Pricing & Description
        ARoundedContainer(
          backgroundColor: darkMode ? AColors.darkGrey : AColors.grey,
          padding: const EdgeInsets.all(ASizes.md),
          child: Column(
            children: [
              // Title, Price and Stock status
              Row(
                children: [
                  // Title
                  const ASectionHeading(
                    title: 'Variation',
                    showActionbutton: false,
                  ),

                  const SizedBox(width: ASizes.spaceBtwItems),

                  // Price and Stock status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Price Text
                          const AProductTitleText(
                            title: "Price: ",
                            smallSize: true,
                          ),

                          /// Actual Price
                          Text(
                            '₹25',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),

                          const SizedBox(width: ASizes.spaceBtwItems),

                          // Sale Price
                          const AProductPriceText(price: '20'),
                        ],
                      ),

                      /// Stock Status
                      Row(
                        children: [
                          // Stock Text
                          const AProductTitleText(
                            title: 'Stock: ',
                            smallSize: true,
                          ),

                          // Stock Status
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              /// Variation Description
              const AProductTitleText(
                title:
                    "This is the description of the product and it can go up to max 4 lines.",
                smallSize: true,
                maxlines: 4,
              ),
            ],
          ),
        ),

        const SizedBox(height: ASizes.spaceBtwItems),

        // Color Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const ASectionHeading(
              title: "Colors",
              showActionbutton: false,
            ),

            const SizedBox(height: ASizes.spaceBtwItems / 2),

            // Attributes
            Wrap(
              spacing: 8,
              children: [
                AChoiceChip(
                  text: 'Green',
                  selected: true,
                  onSelected: (value) {},
                ),
                AChoiceChip(
                  text: 'Blue',
                  selected: false,
                  onSelected: (value) {},
                ),
                AChoiceChip(
                  text: 'Pink',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: ASizes.spaceBtwItems),

        // Size Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const ASectionHeading(
              title: "Size",
              showActionbutton: false,
            ),

            const SizedBox(height: ASizes.spaceBtwItems / 2),

            // Attributes
            Wrap(
              spacing: 8,
              children: [
                AChoiceChip(
                  text: 'EU 34',
                  selected: true,
                  onSelected: (value) {},
                ),
                AChoiceChip(
                  text: 'EU 36',
                  selected: false,
                  onSelected: (value) {},
                ),
                AChoiceChip(
                  text: 'WU 38',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
