import 'package:aurakart/data/repositories/categories/category_repository.dart';
import 'package:aurakart/data/repositories/product/product_repository.dart';
import 'package:aurakart/features/shop/models/category_model.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/screens/sub_category/sub_catogories.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;

  final _categoryRepository = Get.put(CategoryRepository());

  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// Load categories data
  Future<void> fetchCategories() async {
    try {
      // Show loader while categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API , etc..)
      final categories = await _categoryRepository.getAllCategories();

      // Update the categories list
      allCategories.assignAll(categories);

      // Filter featured catgories
      featuredCategories.assignAll(
        allCategories
            .where(
                (category) => category.isFeatured && category.parentId.isEmpty)
            .take(8)
            .toList(),
      );
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }

  /// Load selected category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCatogories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCatogories;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Get category or sub-category products
  Future<List<ProductModel>> getCategoryProducts({
    required String categoryId,
    int limit = 4,
  }) async {
    try {
      // Fecth Limited (4) products against each aubCategory;
      final products = await ProductRepository.instance.getProductsForCategory(
        categoryId: categoryId,
        limit: limit,
      );
      return products;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
