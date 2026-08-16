import 'package:aurakart/features/chatbot/screen/chatbot_button.dart';
import 'package:aurakart/features/personalization/screens/settings/settings.dart';
import 'package:aurakart/features/shop/screens/home/home.dart';
import 'package:aurakart/features/shop/screens/store/store.dart';
import 'package:aurakart/features/shop/screens/wishlist/wishlist.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: _DekozyNavBar(controller: controller),
      body: Stack(
        children: [
          Obx(() => controller.screens[controller.selectedIndex.value]),
          const ChatbotButton(),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Nav bar with sliding physics
// ─────────────────────────────────────────────────────────────────────────────

class _DekozyNavBar extends StatelessWidget {
  const _DekozyNavBar({required this.controller});
  final NavigationController controller;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF1E1E1E) : Colors.white,
        border: Border(
          top: BorderSide(
            color: dark ? Colors.white10 : Colors.black.withValues(alpha: 0.07),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? 0.28 : 0.07),
            blurRadius: 14,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final tabWidth = constraints.maxWidth / 4;
              return Stack(
                children: [
                  // Animated sliding pill
                  Obx(() {
                    final index = controller.selectedIndex.value;
                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.fastOutSlowIn,
                      top: 0,
                      left: index * tabWidth,
                      width: tabWidth,
                      child: Center(
                        child: Container(
                          height: 3,
                          width: 28,
                          decoration: BoxDecoration(
                            color: AColors.primary,
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  // Icons Row
                  Obx(
                    () => Row(
                      children: [
                        _NavItem(
                          icon: Iconsax.home,
                          activeIcon: Iconsax.home_15,
                          label: 'Home',
                          selected: controller.selectedIndex.value == 0,
                          dark: dark,
                          onTap: () => controller.selectedIndex.value = 0,
                        ),
                        _NavItem(
                          icon: Iconsax.shop,
                          activeIcon: Iconsax.shop5,
                          label: 'Store',
                          selected: controller.selectedIndex.value == 1,
                          dark: dark,
                          onTap: () => controller.selectedIndex.value = 1,
                        ),
                        _NavItem(
                          icon: Iconsax.heart,
                          activeIcon: Iconsax.heart5,
                          label: 'Wishlist',
                          selected: controller.selectedIndex.value == 2,
                          dark: dark,
                          onTap: () => controller.selectedIndex.value = 2,
                        ),
                        _NavItem(
                          icon: Iconsax.user,
                          activeIcon: Iconsax.user,
                          label: 'Profile',
                          selected: controller.selectedIndex.value == 3,
                          dark: dark,
                          onTap: () => controller.selectedIndex.value = 3,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single nav item
// ─────────────────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.dark,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final bool dark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final active = AColors.primary;
    final inactive = dark ? Colors.white38 : Colors.black38;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated icon switcher for smooth morphing
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOutBack,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Icon(
                  selected ? activeIcon : icon,
                  key: ValueKey(selected ? 1 : 0),
                  color: selected ? active : inactive,
                  size: selected ? 24 : 22,
                ),
              ),
              const SizedBox(height: 4),
              // Animated text style for smooth weight/color transition
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                style: TextStyle(
                  fontSize: selected ? 11 : 10,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected ? active : inactive,
                  fontFamily: 'Poppins',
                ),
                child: Text(label, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Controller
// ─────────────────────────────────────────────────────────────────────────────

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  final RxInt selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
  ];
}
