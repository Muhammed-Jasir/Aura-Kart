import 'package:aurakart/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:flutter/material.dart';

class ACurvedEdgesWidget extends StatelessWidget {
  const ACurvedEdgesWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ACustomCurvedEdges(),
      child: child,
    );
  }
}
