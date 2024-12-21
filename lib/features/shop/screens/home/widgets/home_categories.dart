import 'package:aurakart/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:aurakart/features/shop/screens/sub_category/sub_catogories.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AHomeCategories extends StatelessWidget {
  const AHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return AVerticalImageText(
            image: AImages.sportIcon,
            title: 'Shoes',
            onTap: () => Get.to(() => const SubCatogoriesScreen()),
          );
        },
      ),
    );
  }
}
