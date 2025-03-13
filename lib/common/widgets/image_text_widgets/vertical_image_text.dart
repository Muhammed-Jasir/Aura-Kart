import 'package:aurakart/common/widgets/images/circular_image.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AVerticalImageText extends StatelessWidget {
  const AVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = AColors.white,
    this.isNetworkImage = true,
    this.backgroundColor,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final bool isNetworkImage;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // final darkMode = AHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: ASizes.spaceBtwItems),
        child: Column(
          children: [
            /// Circular Icon
            ACircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: ASizes.sm,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              // overLayColor: darkMode ? AColors.light : AColors.dark,
            ),

            const SizedBox(height: ASizes.spaceBtwItems / 2),

            /// Text
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: AColors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
