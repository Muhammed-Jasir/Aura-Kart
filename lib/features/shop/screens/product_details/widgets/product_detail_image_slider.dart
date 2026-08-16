import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/images/rounded_image.dart';
import 'package:aurakart/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:aurakart/features/shop/controllers/product/images_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/screens/ar_product/ar_product.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AProductImageSlider extends StatelessWidget {
  const AProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return Container(
      color: darkMode ? AColors.darkerGrey : AColors.white,
      child: Stack(
        children: [
          /// Main Large Image — no artificial padding, full product visibility
          SizedBox(
            height: 380,
            width: double.infinity,
            child: Obx(
              () {
                final image = controller.selectedProductImage.value;
                return GestureDetector(
                  onTap: () => controller.showEnlargedImage(image),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.contain,
                    progressIndicatorBuilder: (_, __, downloadProgress) =>
                        Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: AColors.primary,
                          ),
                        ),
                    errorWidget: (_, __, ___) =>
                        const Icon(Icons.image_not_supported),
                  ),
                );
              },
            ),
          ),

          /// Image Thumbnails strip
          Positioned(
            bottom: 8,
            right: ASizes.defaultSpace,
            left: ASizes.defaultSpace,
            child: SizedBox(
              height: 72,
              child: ListView.separated(
                itemCount: images.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (_, __) =>
                    const SizedBox(width: ASizes.spaceBtwItems / 2),
                itemBuilder: (_, index) => Obx(
                  () {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return ARoundedImage(
                      width: 68,
                      imageUrl: images[index],
                      isNetworkImage: true,
                      fit: BoxFit.contain,
                      backgroundColor:
                          darkMode ? AColors.dark : AColors.lightContainer,
                      border: Border.all(
                        color: imageSelected
                            ? AColors.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                      padding: const EdgeInsets.all(ASizes.xs),
                      onPressed: () => controller.selectedProductImage.value =
                          images[index],
                    );
                  },
                ),
              ),
            ),
          ),

          /// AR overlay button — compact, discoverable, bottom-right of image
          Positioned(
            bottom: 88,
            right: ASizes.defaultSpace,
            child: GestureDetector(
              onTap: () => Get.to(() => ArProductScreen(product: product)),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: ASizes.md, vertical: ASizes.sm),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(ASizes.borderRadiusLg),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.threed_rotation_rounded,
                        color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text('AR · VR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Appbar Icons (back + wishlist)
          AAppBar(
            showBackArrow: true,
            actions: [
              AFavouriteIcon(productId: product.id),
            ],
          ),
        ],
      ),
    );
  }
}
