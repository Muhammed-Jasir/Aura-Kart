import 'package:aurakart/data/repositories/categories/category_repository.dart';
import 'package:aurakart/features/shop/models/category_model.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());

  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featureCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// load categories data
  Future<void> fetchCategories() async {
    try {
      // Show loader while categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API , etc..)
      final categories = await _categoryRepository.getAllCategories();

      // Update the categories list
      allCategories.assignAll(categories);

      // Filter featured catgories
      featureCategories.assignAll(
        allCategories.where(
          (category) => category.isFeatured && category.parentId.isEmpty,
        ).take(8).toList()
      );
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Uh Oh !!', message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }

  /// load selected category data

  /// get category or sub-category products
}
