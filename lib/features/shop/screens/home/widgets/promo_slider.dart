import 'package:aurakart/features/shop/controllers/home/home_controller.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/common/widgets/images/rounded_image.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class APromoSlider extends StatelessWidget {
  const APromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Column(
      children: [
        /// Carousel
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: banners.map((url) => ARoundedImage(imageUrl: url)).toList(),
        ),

        const SizedBox(height: ASizes.spaceBtwItems),

        /// Carousel Dots
        Center(
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < banners.length; i++)
                  ACircularContainer(
                    width: 22,
                    height: 4,
                    margin: const EdgeInsets.only(right: 18),
                    backgroundColor: controller.carouselCurrentIndex.value == i
                        ? AColors.primary
                        : AColors.grey,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
