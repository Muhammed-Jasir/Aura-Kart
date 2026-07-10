import 'package:aurakart/common/widgets/products/ratings/rating_indicator.dart';
import 'package:aurakart/features/shop/controllers/review/review_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class SubmitReviewSection extends StatelessWidget {
  const SubmitReviewSection({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ReviewController.getOrPut(product);

    return Obx(
      () {
        if (!controller.canReview.value) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.userReview.value == null
                  ? 'Write a Review'
                  : 'Update Your Review',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
            RatingBar.builder(
              initialRating: controller.rating.value,
              minRating: 1,
              allowHalfRating: true,
              itemCount: 5,
              unratedColor: AColors.grey,
              itemBuilder: (_, __) =>
                  const Icon(Icons.star, color: AColors.primary),
              onRatingUpdate: (value) => controller.rating.value = value,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
            TextField(
              controller: controller.reviewController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Your review',
                hintText: 'Share your experience with this product',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isSubmitting.value
                    ? null
                    : controller.submitReview,
                child: Text(
                  controller.isSubmitting.value
                      ? 'Submitting...'
                      : ATexts.submit,
                ),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwSections),
            const Divider(),
            const SizedBox(height: ASizes.spaceBtwSections),
          ],
        );
      },
    );
  }
}
