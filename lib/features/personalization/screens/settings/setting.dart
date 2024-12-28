import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:aurakart/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:aurakart/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/features/personalization/screens/profile/profile.dart';
import 'package:aurakart/features/personalization/screens/address/address.dart';
import 'package:aurakart/features/shop/screens/cart/cart.dart';
import 'package:aurakart/features/shop/screens/orders/order.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
                  /// Appbar
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
    
                  /// User Profile Card
                  AUserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),
    
                  const SizedBox(height: ASizes.spaceBtwSections),
                ],
              ),
            ),
    
            /// Body
            Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  /// Account Settings
                  const ASectionHeading(
                    title: 'Account Settings',
                    showActionbutton: false,
                  ),
    
                  const SizedBox(height: ASizes.spaceBtwItems),
    
                  ASettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: "Set shopping delivery address",
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
    
                  ASettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: "Add, remove products and move to checkout",
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
    
                  ASettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: "In-progress and Completed Orders",
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
    
                  ASettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subtitle: "Withdraw balance to registered bank account",
                    onTap: () {},
                  ),
    
                  ASettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subtitle: "List of all the discounted coupons",
                    onTap: () {},
                  ),
    
                  ASettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subtitle: "Set any kind of notification message",
                    onTap: () {},
                  ),
    
                  ASettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: "Mange data usage and Connected accounts",
                    onTap: () {},
                  ),
    
                  const SizedBox(height: ASizes.spaceBtwSections),
    
                  /// App Settings
                  const ASectionHeading(
                    title: "App Settings",
                    showActionbutton: false,
                  ),
    
                  const SizedBox(height: ASizes.spaceBtwItems),
    
                  ASettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: "Load Data",
                    subtitle: "Upload data to your Cloud Firestore",
                    onTap: () {},
                  ),
    
                  ASettingsMenuTile(
                    icon: Iconsax.location,
                    title: "Geolocation",
                    subtitle: "Set recommendation based on location",
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
    
                  ASettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: "Safe Mode",
                    subtitle: "Search result is safe for all ages",
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
    
                  ASettingsMenuTile(
                    icon: Iconsax.image,
                    title: "HD Image Quality",
                    subtitle: "Set image quality to be seen",
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
    
                  const SizedBox(height: ASizes.spaceBtwSections),
    
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () =>
                        Get.offAll(() => AuthenticationRepository.instance.logout()),
                      child: const Text('Logout'),
                    ),
                  ),
    
                  const SizedBox(height: ASizes.spaceBtwSections),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
