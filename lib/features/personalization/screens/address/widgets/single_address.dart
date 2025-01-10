import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/features/personalization/controllers/address_controller.dart';
import 'package:aurakart/features/personalization/models/address_model.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ASingleAddress extends StatelessWidget {
  const ASingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });
  final AddressModel address;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: ARoundedContainer(
          width: double.infinity,
          showBorder: true,
          backgroundColor: selectedAddress
              ? AColors.primary.withValues(alpha: 0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : darkMode
                  ? AColors.darkerGrey
                  : AColors.grey,
          margin: const EdgeInsets.only(bottom: ASizes.spaceBtwItems),
          child: Stack(
            children: [
              // Select Icon
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color: selectedAddress
                      ? darkMode
                          ? AColors.light
                          : AColors.dark
                      : null,
                ),
              ),

              Column(
                children: [
                  // Name
                  Text(
                    'John Due',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: ASizes.sm / 2),

                  // Phone
                  const Text(
                    '+91 99456 78990',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: ASizes.sm / 2),

                  // Address
                  const Text(
                    '82356 Timmy Coves, South Liana, Maine, 87665, USA',
                    softWrap: true,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
