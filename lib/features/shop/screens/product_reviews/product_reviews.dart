import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/products/ratings/rating_indicator.dart';
import 'package:aurakart/features/shop/controllers/review/review_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:aurakart/features/shop/screens/product_reviews/widgets/submit_review_section.dart';
import 'package:aurakart/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/formatters/formatter.dart';
import 'package:aurakart/utils/loaders/animation_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductReviewsScreens extends StatelessWidget {
  const ProductReviewsScreens({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ReviewController.getOrPut(product);

    return Scaffold(
      appBar: const AAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const AAnimationLoaderWidget(
              text: 'Loading reviews...',
              animation: AImages.docerAnimation,
            );
          }

          final reviewStats = controller.stats.value;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ratings and reviews come from customers who purchased and received this product.',
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems),
                  if (reviewStats.totalReviews == 0)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: ASizes.spaceBtwSections,
                        ),
                        child: Text(
                          'No reviews yet. Be the first to review this product.',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else ...[
                    AOverallProductRating(
                      averageRating: reviewStats.averageRating,
                      distribution: reviewStats.distribution,
                    ),
                    ARatingBarIndictator(rating: reviewStats.averageRating),
                    Text(
                      AFormatter.formatCount(reviewStats.totalReviews),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: ASizes.spaceBtwSections),
                  ],
                  SubmitReviewSection(product: product),
                  if (controller.reviews.isEmpty)
                    const SizedBox.shrink()
                  else
                    ...controller.reviews
                        .map((review) => UserReviewCard(review: review)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
