import 'package:aurakart/data/repositories/brands/brand_repository.dart';
import 'package:aurakart/data/repositories/product/product_repository.dart';
import 'package:aurakart/features/shop/models/brand_model.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  /// Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      // Show loader while loading Brands
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4));

    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get Brands for Category

  

  /// Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    try {
    final products = await ProductRepository.instance.getProductsForBrand(brandId: brandId);
    return products;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
  
}
