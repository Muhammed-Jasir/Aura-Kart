import 'package:aurakart/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class ARatingBarIndictator extends StatelessWidget {
  const ARatingBarIndictator({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 18,
      unratedColor: AColors.grey,
      itemBuilder: (_, __) => const Icon(Iconsax.star1, color: AColors.primary),
    );
  }
}
