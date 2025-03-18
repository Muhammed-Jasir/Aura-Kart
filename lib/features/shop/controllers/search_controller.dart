import 'package:aurakart/data/repositories/product/product_repository.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProductController extends GetxController {
  static SearchProductController get instance => Get.find();

  final repository = ProductRepository.instance;

  RxBool isLoading = false.obs;

  final searchTextController = TextEditingController();

  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (allProducts.isEmpty) {
      fetchProducts();
    }
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      final products = await repository.getAllFeaturedProducts();
      allProducts.assignAll(products);

      filteredProducts.clear();
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) async {
    try {
      if (query.trim().isEmpty) {
        filteredProducts.clear();
        return;
      }

      filteredProducts.assignAll(
        allProducts
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
