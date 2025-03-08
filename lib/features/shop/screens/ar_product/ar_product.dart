import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/texts/product_title_text.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../../common/widgets/products/favourite_icon/favourite_icon.dart';

class ArProductScreen extends StatelessWidget {
  const ArProductScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        showBackArrow: true,
        title: AProductTitleText(title: product.title),
      ),
      body: Center(
        child: ModelViewer(
          src: product.armodel,
          alt: product.title,
          ar: true,
          arModes: const ['scene-viewer', 'webxr','quick-look'],
          autoPlay: true,
          cameraControls: true,
          arPlacement: ArPlacement.floor,
          autoRotate: true,
        ),
      )
    );
  }
}
