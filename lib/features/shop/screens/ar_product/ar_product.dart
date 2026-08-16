import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/texts/product_title_text.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../../common/widgets/products/favourite_icon/favourite_icon.dart';

class ArProductScreen extends StatefulWidget {
  const ArProductScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ArProductScreen> createState() => _ArProductScreenState();
}

class _ArProductScreenState extends State<ArProductScreen> {
  // false = AR mode, true = VR / immersive mode
  bool _vrMode = false;

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AAppBar(
        showBackArrow: true,
        title: AProductTitleText(title: widget.product.title),
        actions: [
          AFavouriteIcon(productId: widget.product.id),
        ],
      ),
      body: Stack(
        children: [
          // Model viewer fills the screen
          ModelViewer(
            src: widget.product.armodel,
            alt: widget.product.title,
            ar: !_vrMode,                    // AR only in AR mode
            arModes: const ['scene-viewer', 'webxr', 'quick-look'],
            autoPlay: true,
            cameraControls: true,
            arPlacement: ArPlacement.floor,
            autoRotate: true,
            // VR mode: enable XR environment + skybox
            xrEnvironment: _vrMode,
          ),

          // AR / VR toggle pill — bottom centre
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: darkMode
                      ? Colors.black87
                      : Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ModeButton(
                      label: 'AR',
                      icon: Icons.view_in_ar_rounded,
                      selected: !_vrMode,
                      onTap: () => setState(() => _vrMode = false),
                    ),
                    _ModeButton(
                      label: 'VR',
                      icon: Icons.vrpano_rounded,
                      selected: _vrMode,
                      onTap: () => setState(() => _vrMode = true),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: selected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
