import 'package:aurakart/common/widgets/images/circular_image.dart';
import 'package:aurakart/common/widgets/shimmers/shimmer.dart';
import 'package:aurakart/features/personalization/controllers/user_controller.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AUserProfileTile extends StatelessWidget {
  const AUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return ListTile(
      // User Image
      leading: Obx(
        () {
          return controller.profileLoading.value
              ? AShimmerEffect(width: 50, height: 50, radius: 50)
              : ACircularImage(
                  image: controller.user.value.profilePicture.isNotEmpty
                      ? controller.user.value.profilePicture
                      : AImages.user,
                  isNetworkImage:
                      controller.user.value.profilePicture.isNotEmpty
                          ? true
                          : false,
                  width: 50,
                  height: 50,
                  padding: 0,
                );
        },
      ),

      // Name
      title: Obx(
        () => controller.profileLoading.value
            ? AShimmerEffect(width: 100, height: 20)
            : Text(
                controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: AColors.white),
              ),
      ),

      // Email
      subtitle: Text(
        controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: AColors.white),
      ),

      // Edit Icon
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(Iconsax.edit, color: AColors.white),
      ),
    );
  }
}
