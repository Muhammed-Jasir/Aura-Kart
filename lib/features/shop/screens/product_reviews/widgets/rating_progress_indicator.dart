import 'package:aurakart/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:flutter/material.dart';

class AOverallProductRating extends StatelessWidget {
  const AOverallProductRating({
    super.key,
    required this.averageRating,
    required this.distribution,
  });

  final double averageRating;
  final Map<int, double> distribution;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            averageRating.toStringAsFixed(1),
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              for (final star in [5, 4, 3, 2, 1])
                ARatingProgressIndicator(
                  text: '$star',
                  value: distribution[star] ?? 0,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
