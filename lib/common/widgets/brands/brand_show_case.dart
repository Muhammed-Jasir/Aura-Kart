import 'package:aurakart/common/widgets/brands/brand_card.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/shimmers/shimmer.dart';
import 'package:aurakart/features/shop/models/brand_model.dart';
import 'package:aurakart/features/shop/screens/brand/brand_products.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ABrandShowcase extends StatelessWidget {
  const ABrandShowcase({
    super.key,
    required this.images,
    required this.brand,
  });

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: ARoundedContainer(
        showBorder: true,
        borderColor: AColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(ASizes.md),
        margin: const EdgeInsets.only(bottom: ASizes.spaceBtwItems),
        child: Column(
          children: [
            // Brands with Product Count
            ABrandCard(showBorder: false, brand: brand),
            const SizedBox(height: ASizes.spaceBtwItems),

            // Brand Top 3 Product Images
            Row(
              children: images
                  .map((image) => brandTopProductImageWidget(image, context))
                  .toList(),
            ),
          ],
        ),
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
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: image,
        progressIndicatorBuilder: (context, url, downloadprogress) =>
            const AShimmerEffect(width: 100, height: 100),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    ),
  );
}
