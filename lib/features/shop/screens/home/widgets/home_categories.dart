import 'package:aurakart/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:aurakart/common/widgets/shimmers/category_shimmer.dart';
import 'package:aurakart/features/shop/controllers/category_controller.dart';
import 'package:aurakart/features/shop/screens/sub_category/sub_catogories.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AHomeCategories extends StatelessWidget {
  const AHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(
      () {
        if (categoryController.isLoading.value) return const ACategoryShimmer();

        if (categoryController.featuredCategories.isEmpty) {
          return Center(
            child: Text(
              'No Data Found!',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.white),
            ),
          );
        }

        return SizedBox(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];

              return AVerticalImageText(
                image: category.image,
                title: category.name,
                onTap: () =>
                    Get.to(() => SubCategoriesScreen(category: category)),
              );
            },
          ),
        );
      },
    );
  }
}
