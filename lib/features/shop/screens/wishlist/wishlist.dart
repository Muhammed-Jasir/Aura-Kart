import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/icons/circular_icon.dart';
import 'package:aurakart/common/widgets/layouts/grid_layout.dart';
import 'package:aurakart/common/widgets/products/product-cards/product_card_veritcal.dart';
import 'package:aurakart/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:aurakart/features/shop/controllers/product/favourites_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/screens/home/home.dart';
import 'package:aurakart/navigation_menu.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/cloud_helper_functions.dart';
import 'package:aurakart/utils/loaders/animation_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    return Scaffold(
      // Appbar
      appBar: AAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          ACircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(HomeScreen(products: product)),
          ),
        ],
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),

          //products grid

          child: Obx(
            () => FutureBuilder(
                future: controller.favoriteProducts(),
                builder: (context, snapshot) {
                  //nothing found widget
                  final emptyWidget = AAnimationLoaderWidget(
                    text: 'oops! Wishlist is Empty',
                    animation: AImages.pencilAnimaton,
                    showAction: true,
                    actionText: 'Lets\'s add some',
                    onActionPressed: () => Get.off(() => const NavigationMenu()),
                  );
                  const loader = AVerticalProductShimmer(itemCount: 6);
                  final widget = ACloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                      nothingFound: emptyWidget);
                  if (widget != null) return widget;
            
                  final product = snapshot.data!; 
                  return AGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) =>
                        AProductCardVertical(product: products[index]) );
                }),
          ),
        ),
      ),
    );
  }
}
