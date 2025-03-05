import 'package:aurakart/common/widgets/chips/choice_chips.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/texts/product_price_text.dart';
import 'package:aurakart/common/widgets/texts/product_title_text.dart';
import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/features/shop/controllers/product/variation_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AProductAttributes extends StatelessWidget {
  const AProductAttributes({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    final controller = Get.put(VariationController());

    return Obx(
      () => Column(
        children: [
          // Selected Attribute Pricing & Description
          // Display variation price and stock when some variation is selected.
          if (controller.selectedVariation.value.id.isNotEmpty)
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
                          title: 'Variation', showActionbutton: false),

                      const SizedBox(width: ASizes.spaceBtwItems),

                      // Price and Stock status
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Price Text
                              const AProductTitleText(
                                  title: "Price : ", smallSize: true),

                              /// Actual Price
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  '\u{20B9}${controller.selectedVariation.value.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),

                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                const SizedBox(width: ASizes.spaceBtwItems),

                              // Sale Price
                              AProductPriceText(
                                  price: controller.getVariationPrice()),
                            ],
                          ),

                          /// Stock Status
                          Row(
                            children: [
                              // Stock Text
                              const AProductTitleText(
                                  title: 'Stock: ', smallSize: true),

                              // Stock Status
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// Variation Description
                  AProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxlines: 4,
                  ),
                ],
              ),
            ),

          const SizedBox(height: ASizes.spaceBtwItems),

          // Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      ASectionHeading(
                          title: attribute.name ?? '', showActionbutton: false),

                      const SizedBox(height: ASizes.spaceBtwItems / 2),

                      // Attributes
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.values!.map(
                            (attributeValue) {
                              final isSelected = controller
                                      .selectedAttributes[attribute.name] ==
                                  attributeValue;

                              final available = controller
                                  .getAttributesAvailabilityInVariation(
                                    product.productVariations!,
                                    attribute.name!,
                                  )
                                  .contains(attributeValue);

                              return AChoiceChip(
                                text: attributeValue,
                                selected: isSelected,
                                onSelected: available
                                    ? (selected) {
                                        if (selected && available) {
                                          controller.onAttributeSelected(
                                            product,
                                            attribute.name ?? '',
                                            attributeValue,
                                          );
                                        }
                                      }
                                    : null,
                              );
                            },
                          ).toList(),
                        ),
                      ),

                      const SizedBox(height: ASizes.spaceBtwItems),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
