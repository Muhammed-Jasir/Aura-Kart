import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/products/ratings/rating_indicator.dart';
import 'package:aurakart/features/shop/models/review_model.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/formatters/formatter.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({
    super.key,
    required this.review,
  });

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);
    final hasSellerReply =
        review.sellerReply != null && review.sellerReply!.trim().isNotEmpty;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: review.userImage.isNotEmpty
                      ? CachedNetworkImageProvider(review.userImage)
                      : const AssetImage(AImages.user) as ImageProvider,
                ),
                const SizedBox(width: ASizes.spaceBtwItems),
                Text(
                  review.userName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwItems),
        Row(
          children: [
            ARatingBarIndictator(rating: review.rating),
            const SizedBox(width: ASizes.spaceBtwItems),
            Text(
              AFormatter.formatDate(review.createdAt),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwItems),
        ReadMoreText(
          review.comment,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: ' less',
          trimCollapsedText: ' more',
          moreStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AColors.primary,
          ),
          lessStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AColors.primary,
          ),
        ),
        if (hasSellerReply) ...[
          const SizedBox(height: ASizes.spaceBtwItems),
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
                        'Dekozy',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (review.sellerReplyAt != null)
                        Text(
                          AFormatter.formatDate(review.sellerReplyAt),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems),
                  ReadMoreText(
                    review.sellerReply!,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimExpandedText: ' less',
                    trimCollapsedText: ' more',
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AColors.primary,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: ASizes.spaceBtwSections),
      ],
    );
  }
}
