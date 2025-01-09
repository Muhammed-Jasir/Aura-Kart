import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:aurakart/common/widgets/shimmers/shimmer.dart';
import 'package:aurakart/features/personalization/controllers/user_controller.dart';
import 'package:aurakart/features/shop/screens/cart/cart.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AHomeAppbar extends StatelessWidget {
  const AHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return AAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            ATexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: AColors.grey),
          ),

          // Sub-Title
          Obx(
            () {
              if (controller.profileLoading.value) {
                /// Display a Shimmer Loader while user profile is being loaded
                return const AShimmerEffect(width: 80, height: 15);
              } else {
                return Text(
                  controller.user.value.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: AColors.white),
                );
              }
            },
          ),
        ],
      ),
      actions: const [
        // Cart Icon
        ACartCouterIcon(
          counterBgColor: AColors.black,
          counterTextColor: AColors.white,
          iconColor: AColors.white,
        ),
      ],
    );
  }
}
