import 'package:aurakart/common/widgets/success_screen/success_screen.dart';
import 'package:aurakart/data/repositories/order/order_repository.dart';
import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/features/personalization/controllers/address_controller.dart';
import 'package:aurakart/features/shop/controllers/stripe_payment_controller.dart';
import 'package:aurakart/features/shop/controllers/product/cart_controller.dart';
import 'package:aurakart/features/shop/controllers/product/checkout_controller.dart';
import 'package:aurakart/features/shop/models/order_model.dart';
import 'package:aurakart/navigation_menu.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/popups/full_screen_loader.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variable
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
      ALoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Add methods for order processing
  void processOrder(
    String selectedPaymentMethod,
    double totalAmount,
    double shippingCost,
    double taxCost,
  ) async {
    try {
      // Start Loader
      AFullScreenLoader.openLoadingDialog(
          'Processing your order', AImages.pencilAnimaton);

      // Get user authentication Id
      final userId = AuthenticationRepository.instance.authUser!.uid;

      if (userId.isEmpty) {
        AFullScreenLoader.stopLoading();
        ALoaders.errorSnackBar(
            title: 'Invalid User', message: 'User not found.');
        return;
      }
      if (cartController.cartItems.isEmpty) {
        AFullScreenLoader.stopLoading();
        ALoaders.warningSnackBar(
          title: 'Empty Cart',
          message: 'Add items in the cart in order to proceed',
        );
        return;
      }

      if (!addressController.selectedAddress.value.selectedAddress ||
          addressController.selectedAddress.value.id.isEmpty) {
        AFullScreenLoader.stopLoading();
        ALoaders.warningSnackBar(
          title: 'Select Address',
          message: 'Please select a address',
        );
        return;
      }

      final paymentController = Get.put(StripePaymentController());

      // Process payment first.
      if (selectedPaymentMethod == 'Stripe') {
        await paymentController.makeStripePayment(
            amount: totalAmount.toString(), currency: 'inr');

        if (!paymentController.paymentStatus.value) {
          AFullScreenLoader.stopLoading();
          return;
        }
      }

      // Add details
      final order = OrderModel(
        id: UniqueKey().toString(),
        docId: '',
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        shippingCost: shippingCost,
        taxCost: taxCost,
        orderDate: DateTime.now(),
        items: cartController.cartItems.toList(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        shippingAddress: addressController.selectedAddress.value,
        billingAddress: addressController.selectedAddress.value,
        deliveryDate: DateTime.now().add(const Duration(days: 3)),
      );

      // Save the order to Firestore
      await orderRepository.saveOrder(order);

      // Update the cart status
      cartController.clearCart();

      // Show Success screen
      Get.offAll(
        () => SuccessScreen(
          image: AImages.orderCompletedAnimation,
          title: 'Order Successfully Placed!',
          subTitle: 'Your item will be shipped soon!',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ),
      );
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      AFullScreenLoader.stopLoading();
    }
  }
}
