import 'package:aurakart/common/widgets/images/circular_image.dart';
import 'package:aurakart/features/personalization/controllers/user_controller.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
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
      leading: const ACircularImage(
        image: AImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),

      // Name
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: AColors.white),
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
