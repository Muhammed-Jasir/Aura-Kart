import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/images/circular_image.dart';
import 'package:aurakart/common/widgets/shimmers/shimmer.dart';
import 'package:aurakart/features/personalization/controllers/user_controller.dart';
import 'package:aurakart/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const AAppBar(showBackArrow: true, title: Text('My Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Hero banner ──────────────────────────────────────────
            Container(
              width: double.infinity,
              color: AColors.primary.withValues(alpha: darkMode ? 0.15 : 0.12),
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  // Avatar + camera badge
                  Obx(() {
                    final networkImage =
                        controller.user.value.profilePicture;
                    final image = networkImage.isNotEmpty
                        ? networkImage
                        : AImages.user;
                    return GestureDetector(
                      onTap: () => controller.uploadUserProfilePicture(),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          controller.imageUploading.value
                              ? const AShimmerEffect(
                                  width: 100,
                                  height: 100,
                                  radius: 50,
                                )
                              : ACircularImage(
                                  width: 100,
                                  height: 100,
                                  image: image,
                                  fit: BoxFit.cover,
                                  isNetworkImage: networkImage.isNotEmpty,
                                ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: darkMode
                                    ? AColors.dark
                                    : Colors.white,
                                width: 2,
                              ),
                            ),
                            child: const Icon(Iconsax.camera,
                                color: Colors.white, size: 14),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 12),

                  // Full name
                  Obx(() => Text(
                        controller.user.value.fullName,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      )),

                  const SizedBox(height: 4),

                  // Email
                  Obx(() => Text(
                        controller.user.value.email,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                                color: darkMode
                                    ? Colors.white54
                                    : Colors.black45),
                      )),
                ],
              ),
            ),

            // ── Info cards ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  _SectionCard(
                    title: 'Profile Information',
                    darkMode: darkMode,
                    children: [
                      _InfoRow(
                        icon: Iconsax.user,
                        label: 'Full Name',
                        value: controller.user.value.fullName,
                        trailing: IconButton(
                          icon: const Icon(Iconsax.edit, size: 18),
                          onPressed: () => Get.to(() => const ChangeName()),
                        ),
                        darkMode: darkMode,
                      ),
                      _InfoRow(
                        icon: Iconsax.user_tag,
                        label: 'Username',
                        value: controller.user.value.username,
                        darkMode: darkMode,
                      ),
                    ],
                  ),

                  const SizedBox(height: ASizes.spaceBtwItems),

                  _SectionCard(
                    title: 'Personal Information',
                    darkMode: darkMode,
                    children: [
                      // Short user ID with copy
                      Obx(() {
                        final fullId = controller.user.value.id;
                        final shortId = fullId.length > 8
                            ? '${fullId.substring(0, 8).toUpperCase()}…'
                            : fullId.toUpperCase();
                        return _InfoRow(
                          icon: Iconsax.hashtag,
                          label: 'User ID',
                          value: shortId,
                          darkMode: darkMode,
                          trailing: IconButton(
                            icon: const Icon(Iconsax.copy, size: 18),
                            tooltip: 'Copy full ID',
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: fullId));
                              Get.snackbar(
                                'Copied',
                                'User ID copied to clipboard',
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 2),
                              );
                            },
                          ),
                        );
                      }),

                      Obx(() => _InfoRow(
                            icon: Iconsax.sms,
                            label: 'Email',
                            value: controller.user.value.email,
                            darkMode: darkMode,
                          )),

                      Obx(() => _InfoRow(
                            icon: Iconsax.call,
                            label: 'Phone',
                            value: controller.user.value.phoneNumber.isEmpty
                                ? 'Not set'
                                : controller.user.value.phoneNumber,
                            darkMode: darkMode,
                          )),
                    ],
                  ),

                  const SizedBox(height: ASizes.spaceBtwSections),

                  // Close account
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          controller.deleteAccountWarningPopup(),
                      icon: const Icon(Iconsax.trash,
                          color: Colors.red, size: 18),
                      label: const Text('Close Account',
                          style: TextStyle(color: Colors.red)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.children,
    required this.darkMode,
  });

  final String title;
  final List<Widget> children;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkMode ? AColors.darkerGrey : Colors.white,
        borderRadius: BorderRadius.circular(ASizes.cardRadiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: darkMode ? 0.25 : 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                ASizes.md, ASizes.md, ASizes.md, 0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
            ),
          ),
          const SizedBox(height: 4),
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.darkMode,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool darkMode;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: ASizes.md, vertical: ASizes.sm),
      child: Row(
        children: [
          Icon(icon,
              size: 18,
              color: darkMode ? Colors.white54 : Colors.black38),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color:
                            darkMode ? Colors.white38 : Colors.black38,
                      ),
                ),
                const SizedBox(height: 1),
                Text(
                  value.isEmpty ? '—' : value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
