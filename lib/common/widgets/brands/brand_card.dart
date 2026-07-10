import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/images/circular_image.dart';
import 'package:aurakart/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:aurakart/features/shop/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';

class ABrandCard extends StatelessWidget {
  const ABrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.brand,
    this.productCount,
  });

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;
  final int? productCount;

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);
    final count = productCount ?? brand.productsCount ?? 0;

    return GestureDetector(
      onTap: onTap,

      /// Container Design
      child: ARoundedContainer(
        padding: const EdgeInsets.all(ASizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Icon
            Flexible(
              child: ACircularImage(
                isNetworkImage: true,
                image: brand.image,
                backgroundColor: Colors.transparent,
                fit: BoxFit.fill,
                // overLayColor: darkMode ? AColors.white : AColors.black,
              ),
            ),

            const SizedBox(width: ASizes.md),

            /// Text
            // Expanded and Column [minAxisSize] is required to keep the elements in vertical center and
            // also to keep the text inside the box
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ABrandTitleWithVerifiedIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                    textColor: darkMode ? AColors.white : AColors.dark,
                  ),
                  Text(
                    '$count products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.apply(
                          color: darkMode
                              ? AColors.white.withValues(alpha: 0.7)
                              : null,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
