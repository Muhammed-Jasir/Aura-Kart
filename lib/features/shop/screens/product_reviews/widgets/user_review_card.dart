import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/products/ratings/rating_indicator.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        // User Review
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // User Avatar
                const CircleAvatar(
                  backgroundImage: AssetImage(AImages.userProfileImage2),
                ),

                const SizedBox(width: ASizes.spaceBtwItems),

                // Name
                Text('Nihal', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),

            // More Icon
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),

        const SizedBox(height: ASizes.spaceBtwItems),

        /// Review Star & Rating
        Row(
          children: [
            const ARatingBarIndictator(rating: 4),
            const SizedBox(width: ASizes.spaceBtwItems),
            Text('01 Nov, 2023', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),

        const SizedBox(height: ASizes.spaceBtwItems),

        // Review Text
        const ReadMoreText(
          'I JUST LOVE THIS APP FROM BOTTOM OF MY HEART. I JUST LOVE THIS APP FROM BOTTOM OF MY HEART. I JUST LOVE THIS APP FROM BOTTOM OF MY HEART. I JUST LOVE THIS APP FROM BOTTOM OF MY HEART.',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: ' less',
          trimCollapsedText: ' more',
          moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AColors.primary,
          ),
          lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AColors.primary,
          ),
        ),

        const SizedBox(height: ASizes.spaceBtwItems),

        /// Company Review
        ARoundedContainer(
          backgroundColor: darkMode ? AColors.darkerGrey : AColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(ASizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Aura-Kart",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "02 Nov, 2024",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),

                const SizedBox(height: ASizes.spaceBtwItems),

                // Review Text
                const ReadMoreText(
                  'I JUST LOVE THIS APP FROM BOTTOM OF MY HEART ',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' less',
                  trimCollapsedText: ' more',
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AColors.primary,
                  ),
                  lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: ASizes.spaceBtwSections),
      ],
    );
  }
}
