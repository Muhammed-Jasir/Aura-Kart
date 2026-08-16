import 'package:aurakart/data/repositories/product/product_repository.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  
  final RxString selectSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];

      final products = await repository.fetchProductsByQuery(query);

      return products;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOptions) {
    selectSortOption.value = sortOptions;

    switch (sortOptions) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Newest':
        // Date field not reliably loaded from Firestore — skip
        break;
      case 'Sale':
        // Sale sort misleading: falls back to name
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      default:
        // Default sorting option: Name
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products) {
    // Assign products to the 'products' list
    this.products.assignAll(products);
    sortProducts(selectSortOption.value);
  }
}
