import 'package:aurakart/features/shop/controllers/product/favourites_controller.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:aurakart/common/widgets/icons/circular_icon.dart';

class AFavouriteIcon extends StatelessWidget {
  const AFavouriteIcon({
    super.key,
   required this.productId });

  final String productId; 

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(() => const ACircularIcon(
      icon: controller.isFavourite(productId) ?  Iconsax.heart5 : Iconsax.heart, 
      color: controller.isFavourite(productId) ? AColors.error : null,
      onPressed: () => controller.toggleFavoriteProduct(productId),
      ),
    );
  }
}
