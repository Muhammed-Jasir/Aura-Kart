import 'dart:convert';

import 'package:aurakart/features/shop/controllers/product/order_controller.dart';
import 'package:aurakart/utils/constants/api_constants.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:aurakart/utils/helpers/network_manager.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/full_screen_loader.dart';

class StripePaymentController extends GetxController {
  static StripePaymentController get instance => Get.find();

  var paymentIntentData = Rx<Map<String, dynamic>?>(null);
  RxBool paymentStatus = false.obs;

  @override
  void onInit() {
    super.onInit();
    initStripe();
  }

  Future<void> initStripe() async {
    Stripe.publishableKey = APIConstants.stripePublishableKey;
    await Stripe.instance.applySettings();
  }

  Future<void> showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      paymentStatus.value = true;

      // Show Success Message
      ALoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Payment successful! Your order is being processed.',
      );

      paymentIntentData.value = null;
    } on StripeException catch (e) {
      paymentStatus.value = false;
      ALoaders.errorSnackBar(title: 'Payment Failed', message: e.toString());
    } catch (e) {
      paymentStatus.value = false;
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Create Payment Intent
  Future<Map<String, dynamic>?> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      // Request body
      Map<String, dynamic> paymentInfo = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      final stripeUrl = APIConstants.stripeApiUrl;

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
        paymentStatus.value = false;
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
        paymentStatus.value = false;
        return;
      }

      // Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: paymentIntentData.value!['client_secret'],
          style: ThemeMode.system,
          merchantDisplayName: ATexts.appName,
        ),
      );

      // Display Payment Sheet
      await showPaymentSheet();
    } catch (e) {
      paymentStatus.value = false;
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      AFullScreenLoader.stopLoading();
    }
  }
}
