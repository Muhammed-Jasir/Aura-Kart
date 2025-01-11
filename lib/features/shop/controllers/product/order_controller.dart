import 'package:aurakart/common/widgets/success_screen/success_screen.dart';
import 'package:aurakart/data/order/order_repository.dart';
import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/features/personalization/controllers/address_controller.dart';
import 'package:aurakart/features/shop/controllers/cart_controller.dart';
import 'package:aurakart/features/shop/controllers/product/checkout_controller.dart';
import 'package:aurakart/features/shop/models/order_model.dart';
import 'package:aurakart/navigation_menu.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/popups/full_screen_loader.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  ///Variable
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      ALoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  ///  add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      //Start Loader
      AFullScreenLoader.openLoadingDialog(
          'Processing your order', AImages.pencilAnimaton);
      //Get user authentication Id
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) return;
      //Add details
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        items: cartController.cartItems.toList(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
      );

      //Save the order to Firestore
      await orderRepository.saveOrder(order, userId);
      //update the cart status
      cartController.clearCart();
      //Show Success screen
      Get.off(() => SuccessScreen(
            image: AImages.orderCompletedAnimation,
            title: 'Payment Success',
            subTitle: 'Your item will be shipped soon!',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ));
    } catch (e) {
      ALoaders.errorSnackBar(title: 'oh snap', message: e.toString());
    }
  }
}
