import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:aurakart/common/widgets/icons/circular_icon.dart';
import 'package:aurakart/common/widgets/images/rounded_image.dart';
import 'package:aurakart/features/shop/controllers/product/images_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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

    return ACurvedEdgesWidget(
      child: Container(
        color: darkMode ? AColors.darkerGrey : AColors.white,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(ASizes.productImageRadius * 2),
                child: Center(
                  child: Obx(
                    () {
                      final image = controller.selectedProductImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (_, __, downloadProgress) =>
                              CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: AColors.primary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: ASizes.defaultSpace,
              bottom: 30,
              left: ASizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: ASizes.spaceBtwItems),
                  itemBuilder: (_, index) => Obx(
                    () {
                      final imageSelected =
                          controller.selectedProductImage.value ==
                              images[index];
                      return ARoundedImage(
                        width: 80,
                        imageUrl: images[index],
                        isNetworkImage: true,
                        backgroundColor:
                            darkMode ? AColors.dark : AColors.white,
                        border: Border.all(
                          color: imageSelected
                              ? AColors.primary
                              : Colors.transparent,
                        ),
                        padding: const EdgeInsets.all(ASizes.sm),
                        onPressed: () => controller.selectedProductImage.value =
                            images[index],
                      );
                    },
                  ),
                ),
              ),
            ),

            /// Appbar Icons
            const AAppBar(
              showBackArrow: true,
              actions: [
                ACircularIcon(icon: Iconsax.heart5, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
