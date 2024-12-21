import 'package:aurakart/common/widgets/products/ratings/rating_indicator.dart';
import 'package:aurakart/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:aurakart/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:aurakart/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class ProductReviewsScreens extends StatelessWidget {
  const ProductReviewsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: const AAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ratings and Reviews are verified and are from people who use the the same type of devices that you use.",
              ),
              const SizedBox(height: ASizes.spaceBtwItems),

              /// Overall Product Ratings
              const AOverallProductRating(),
              const ARatingBarIndictator(rating: 3.5),
              Text("12,611", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// User Reviews List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
