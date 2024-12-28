import 'package:aurakart/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:aurakart/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class APrimaryHeaderContainer extends StatelessWidget {
  const APrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ACurvedEdgesWidget(
      child: Container(
        color: AColors.primary,
        padding: const EdgeInsets.only(bottom: 0),
        child: Stack(
          children: [
            /// Background Custom Shapes
            // First Circle
            Positioned(
              top: -150,
              right: -250,
              child: ACircularContainer(
                backgroundColor: AColors.white.withValues(alpha: 0.1),
              ),
            ),

            // Second Circle
            Positioned(
              top: 100,
              right: -300,
              child: ACircularContainer(
                backgroundColor: AColors.white.withValues(alpha: 0.1),
              ),
            ),

            child,
          ],
        ),
      ),
    );
  }
}
