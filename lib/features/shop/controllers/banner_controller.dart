import 'package:aurakart/data/repositories/banners/banner_repository.dart';
import 'package:aurakart/features/shop/models/banner_model.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();
  
  /// Variables
  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  /// Update Page Navigational Dots
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  /// Fetch Banners
  Future<void> fetchBanners() async {
    try {
      // Show loader while loading banners
      isLoading.value = true;

      // fetch Banners
      final bannerRepository = Get.put(BannerRepository());
      final banners = await bannerRepository.fetchBanners();

      // Assign Banners
      this.banners.assignAll(banners);

    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }
}
