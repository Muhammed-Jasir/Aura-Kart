import 'package:aurakart/features/shop/controllers/review/review_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ARatingAndShare extends StatelessWidget {
  const ARatingAndShare({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ReviewController.getOrPut(product);

    return Obx(
      () {
        final stats = controller.stats.value;
        final ratingText = stats.totalReviews == 0
            ? '—'
            : stats.averageRating.toStringAsFixed(1);
        final countText = stats.totalReviews == 0
            ? '(0)'
            : '(${AFormatter.formatCount(stats.totalReviews)})';

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Iconsax.star5, color: Colors.amber, size: 24),
                const SizedBox(width: ASizes.spaceBtwItems / 2),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '$ratingText ',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextSpan(text: countText),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share, size: ASizes.iconMd),
            ),
          ],
        );
      },
    );
  }
}
