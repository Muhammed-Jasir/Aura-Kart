import 'package:aurakart/data/repositories/banners/banner_repository.dart';
import 'package:aurakart/features/shop/models/banner_model.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  /// Variables
  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  /// Update page Navigational Dats
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  ///fetch Banners
  Future<void> fetchBanners() async {
    try {
      // Show loader while categories
      isLoading.value = true;

      // fetch Banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      // Assign Banners
      this.banners.assignAll(banners);
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Uh Oh !!', message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }
}
