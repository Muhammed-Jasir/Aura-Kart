import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/images/circular_image.dart';
import 'package:aurakart/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:aurakart/common/widgets/texts/product_price_text.dart';
import 'package:aurakart/common/widgets/texts/product_title_text.dart';
import 'package:aurakart/features/shop/controllers/product/product_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AProductMetaData extends StatelessWidget {
  const AProductMetaData({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Sale Tag
            ARoundedContainer(
              radius: ASizes.sm,
              backgroundColor: AColors.secondary.withValues(alpha: 0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: ASizes.sm, vertical: ASizes.xs),
              child: Text(
                '$salePercentage%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: AColors.black),
              ),
            ),

            const SizedBox(width: ASizes.spaceBtwItems),

            /// Old Price
            if (product.productType == ProductType.single.toString() && product.salePrice > 0)
              Text(
                '₹${product.price}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough),
              ),

            if (product.productType == ProductType.single.toString() && product.salePrice > 0)
              const SizedBox(width: ASizes.spaceBtwItems),

            // New Price
            AProductPriceText(price: controller.getProductPrice(product), isLarge: true),
          ],
        ),

        const SizedBox(height: ASizes.spaceBtwItems / 1.5),

        /// Product Title
        AProductTitleText(title: product.title),
        const SizedBox(height: ASizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            const AProductTitleText(title: 'Status:'),
            const SizedBox(width: ASizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),

        const SizedBox(height: ASizes.spaceBtwItems / 1.5),

        /// Brand
        Row(
          children: [
            // Brand Icon
            ACircularImage(
              image: product.brand != null ? product.brand!.image : '',
              width: 32,
              height: 32,
              overLayColor: darkMode ? AColors.white : AColors.black,
            ),

            const SizedBox(width: ASizes.spaceBtwItems / 4),

            ABrandTitleWithVerifiedIcon(
              title: product.brand != null ? product.brand!.name : '',
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
