import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/appbar/tabbar.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/search_container.dart';
import 'package:aurakart/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:aurakart/features/shop/controllers/brand_controller.dart';
import 'package:aurakart/features/shop/controllers/category_controller.dart';
import 'package:aurakart/features/shop/screens/search/search.dart';
import 'package:aurakart/features/shop/screens/store/widgets/category_tab.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);
    final categories = CategoryController.instance.featuredCategories;
    // Initialize so CategoryTab's brand sections work
    Get.put(BrandController());

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AAppBar(
          title: Text('Store',
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            ACartCouterIcon(
                iconColor: darkMode ? AColors.white : AColors.black),
          ],
        ),
        body: Column(
          children: [
            // Search bar — outside SliverAppBar, so it gets proper constraints
            Padding(
              padding: const EdgeInsets.fromLTRB(
                ASizes.defaultSpace,
                ASizes.defaultSpace,
                ASizes.defaultSpace,
                0,
              ),
              child: ASearchContainer(
                text: 'Search in Store',
                showBorder: true,
                showBackground: false,
                padding: EdgeInsets.zero,
                onTap: () => Get.to(() => const SearchScreen()),
              ),
            ),

            // Tab bar
            ATabBar(
              tabs: categories
                  .map((category) => Tab(child: Text(category.name)))
                  .toList(),
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                children: categories
                    .map((category) => ACategoryTab(category: category))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
