import 'package:aurakart/common/widgets/list_tiles/payment_tyle.dart';
import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/features/shop/models/payment_method_model.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();
  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;
  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(image: AImages.paypal, name: 'Paypal');
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(ASizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ASectionHeading(
                  title: 'Select Payment Method', showActionbutton: false),
              const SizedBox(height: ASizes.spaceBtwSections),
              APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'PayPal', image: AImages.paypal)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              const SizedBox(height: ASizes.spaceBtwSections),
              APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Google Pay', image: AImages.googlePay)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              const SizedBox(height: ASizes.spaceBtwSections),
              APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Apple Pay', image: AImages.applePay)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              const SizedBox(height: ASizes.spaceBtwSections),
              APaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'VISA', image: AImages.visa)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              const SizedBox(height: ASizes.spaceBtwSections),
              APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Master Card', image: AImages.masterCard)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              const SizedBox(height: ASizes.spaceBtwSections),
              APaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'Paytm', image: AImages.paytm)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              const SizedBox(height: ASizes.spaceBtwSections),
              APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paystack', image: AImages.paystack)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              const SizedBox(height: ASizes.spaceBtwSections),
              APaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Credit Card', image: AImages.creditCard)),
              const SizedBox(height: ASizes.spaceBtwItems / 2),
            ],
          ),
        ),
      ),
    );
  }
}
