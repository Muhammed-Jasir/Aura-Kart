import 'package:aurakart/features/personalization/controllers/address_controller.dart';
import 'package:aurakart/features/shop/controllers/product/checkout_controller.dart';
import 'package:aurakart/features/shop/controllers/product/favourites_controller.dart';
import 'package:aurakart/features/shop/controllers/product/variation_controller.dart';
import 'package:aurakart/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());
    Get.put(FavouritesController());
  }
}
