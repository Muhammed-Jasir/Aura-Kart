import 'package:aurakart/common/widgets/list_tiles/payment_tile.dart';
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

  final List<PaymentMethodModel> paymentMethods = [
    PaymentMethodModel(name: 'Cash On Delivery', image: AImages.applePay),
    PaymentMethodModel(name: 'Stripe', image: AImages.paystack),   
  ];

  @override
  void onInit() {
    selectedPaymentMethod.value = paymentMethods.first;
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
              Column(
                children: paymentMethods.map(
                  (method) {
                    return Column(
                      children: [
                        APaymentTile(paymentMethod: method),
                        const SizedBox(height: ASizes.spaceBtwItems / 2),
                      ],
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
