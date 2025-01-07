import 'package:aurakart/common/widgets/layouts/grid_layout.dart';
import 'package:aurakart/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class ABrandShimmer extends StatelessWidget {
  const ABrandShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return AGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const AShimmerEffect(width: 300, height: 80),
    );
  }
}
