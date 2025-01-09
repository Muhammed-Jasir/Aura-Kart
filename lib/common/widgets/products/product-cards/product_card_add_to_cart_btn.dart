import 'package:aurakart/features/shop/controllers/cart_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/screens/product_details/product_details.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AProductCardAddToCartButton extends StatelessWidget {
  const AProductCardAddToCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return GestureDetector(
      onTap: () {
        // If the product have variations then show the product details for variation selection.
        // Else add product to the cart.
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(
        () {
          final productQuantityInCart =
              cartController.getProductQuantityInCart(product.id);

          return Container(
            decoration: BoxDecoration(
              color: productQuantityInCart > 0 ? AColors.primary : AColors.dark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(ASizes.cardRadiusMd),
                bottomRight: Radius.circular(ASizes.productImageRadius),
              ),
            ),
            child: SizedBox(
              width: ASizes.iconLg * 1.2,
              height: ASizes.iconLg * 1.2,
              child: Center(
                child: productQuantityInCart > 0
                    ? Text(
                        productQuantityInCart.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: AColors.white),
                      )
                    : const Icon(Iconsax.add, color: AColors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
