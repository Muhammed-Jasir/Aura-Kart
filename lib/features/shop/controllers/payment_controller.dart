import 'dart:convert';

import 'package:aurakart/features/shop/controllers/product/order_controller.dart';
import 'package:aurakart/utils/constants/api_constants.dart';
import 'package:aurakart/utils/helpers/network_manager.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/full_screen_loader.dart';

class PaymentController extends GetxController {
  static PaymentController get instance => Get.find();

  var paymentIntentData = Rx<Map<String, dynamic>?>(null);

  Future<void> initStripe() async {
    Stripe.publishableKey = APIConstants.stripePublishableKey;
    await Stripe.instance.applySettings();
  }

  Future<void> showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      // Show Success Message
      ALoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Payment successful! Your order is being processed.',
      );

      paymentIntentData.value = null;
    } on StripeException catch (e) {
      ALoaders.errorSnackBar(title: 'Payment Failed', message: e.toString());
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Create Payment Intent
  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      // Request body
      Map<String, dynamic> paymentInfo = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      final stripeUrl = "https://api.stripe.com/v1/payment_intents";

      // Make post request to Stripe
      final response = await http.post(
        Uri.parse(stripeUrl),
        body: paymentInfo,
        headers: {
          'Authorization': 'Bearer ${APIConstants.stripeSecretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw 'Failed to create payment intent';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Calculate amount in cents
  String calculateAmount(String amount) {
    final calculatedAmount = (double.parse(amount) * 100).toInt();
    return calculatedAmount.toString();
  }

  Future<void> makeStripePayment({
    required String amount,
    required String currency,
  }) async {
    try {
      AFullScreenLoader.openLoadingDialog(
          'Loading....', AImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        ALoaders.errorSnackBar(
          title: 'No Internet',
          message: 'Please check your internet connection and try again.',
        );
        return;
      }

      // Create payment intent on the server
      paymentIntentData.value = await createPaymentIntent(amount, currency);
      if (paymentIntentData.value == null) {
        AFullScreenLoader.stopLoading();
        ALoaders.errorSnackBar(
          title: 'Payment Failed',
          message: 'Failed to create payment intent. Please try again.',
        );
        return;
      }

      // Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: paymentIntentData.value!['client_secret'],
          customerId: paymentIntentData.value!['customer'],
          style: ThemeMode.system,
          merchantDisplayName: 'Aurakart',
        ),
      );

      // Display Payment Sheet
      await showPaymentSheet();
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      AFullScreenLoader.stopLoading();
    }
  }

  Future<void> processPayment(
    String method,
    double totalAmount,
    double shippingCost,
    double taxCost,
  ) async {
    try {
      final orderController = Get.put(OrderController());

      if (method == 'Stripe') {
        await makeStripePayment(
            amount: totalAmount.toString(), currency: 'inr');
        orderController.processOrder(totalAmount, shippingCost, taxCost);
      } else if (method == 'Cash On Delivery') {
        orderController.processOrder(totalAmount, shippingCost, taxCost);
      } else {
        ALoaders.warningSnackBar(
          title: 'Payment Method',
          message:
              'Payment method $method is not available yet. Please try again later.',
        );
      }
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Payment Failed', message: e.toString());
    }
  }
}
