import 'dart:ui';
import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:aurakart/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:aurakart/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/features/personalization/screens/profile/profile.dart';
import 'package:aurakart/features/personalization/screens/address/address.dart';
import 'package:aurakart/features/shop/screens/cart/cart.dart';
import 'package:aurakart/features/shop/screens/order/order.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            APrimaryHeaderContainer(
              child: Column(
                children: [
                  AAppBar(
                    title: Text(
                      "Account",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: AColors.white),
                    ),
                  ),
                  const SizedBox(height: ASizes.spaceBtwSections),
                  AUserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),
                  const SizedBox(height: ASizes.spaceBtwSections),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  /// Account Settings — only functional items
                  const ASectionHeading(
                    title: 'Account Settings',
                    showActionbutton: false,
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems),

                  ASettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Manage delivery addresses',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),

                  ASettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'View and edit your cart',
                    onTap: () => Get.to(() => const CartScreen()),
                  ),

                  ASettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'Track orders and view history',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),

                  const SizedBox(height: ASizes.spaceBtwSections),

                  /// App Settings
                  const ASectionHeading(
                    title: 'App Settings',
                    showActionbutton: false,
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems),

                  // Dark / Light mode toggle
                  Obx(() {
                    final tc = ThemeController.instance;
                    return ASettingsMenuTile(
                      icon: tc.isDarkMode.value
                          ? Iconsax.moon
                          : Iconsax.sun_1,
                      title: 'Appearance',
                      subtitle: tc.isDarkMode.value
                          ? 'Dark mode is on'
                          : 'Light mode is on',
                      trailing: Switch(
                        value: tc.isDarkMode.value,
                        onChanged: (_) => tc.toggleTheme(),
                        activeThumbColor: AColors.primary,
                      ),
                    );
                  }),
                  const ASectionHeading(
                    title: 'Legal',
                    showActionbutton: false,
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems),

                  ASettingsMenuTile(
                    icon: Iconsax.shield_tick,
                    title: 'Privacy Policy',
                    subtitle: 'How we handle your data',
                    onTap: () => launchUrl(
                      Uri.parse('https://dekozy.example.com/privacy'),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),

                  ASettingsMenuTile(
                    icon: Iconsax.document_text,
                    title: 'Terms of Service',
                    subtitle: 'Usage terms and conditions',
                    onTap: () => launchUrl(
                      Uri.parse('https://dekozy.example.com/terms'),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),

                  const SizedBox(height: ASizes.spaceBtwSections),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Get.dialog(
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: AlertDialog(
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AColors.darkerGrey
                                    : AColors.white,
                            title: const Text('Logout',
                                textAlign: TextAlign.center),
                            content: const Text(
                                'Are you sure you want to logout?',
                                textAlign: TextAlign.center),
                            actionsAlignment: MainAxisAlignment.center,
                            actionsPadding: const EdgeInsets.only(
                                bottom: ASizes.md, left: ASizes.md, right: ASizes.md),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => Get.back(),
                                      child: const Text('Cancel'),
                                    ),
                                  ),
                                  const SizedBox(width: ASizes.spaceBtwItems),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          AuthenticationRepository.instance
                                              .logout(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        side: const BorderSide(
                                            color: Colors.red),
                                      ),
                                      child: const Text('Logout',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        barrierColor: Colors.black.withValues(alpha: 0.3),
                      ),
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

