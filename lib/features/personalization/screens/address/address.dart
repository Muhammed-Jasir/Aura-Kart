import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/features/personalization/screens/address/add_new_address.dart';
import 'package:aurakart/features/personalization/screens/address/widgets/single_address.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add new Address Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: AColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressscreen()),
        child: const Icon(Iconsax.add, color: AColors.white),
      ),
      
      // Appbar
      appBar: AAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      // Body
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              ASingleAddress(selectedAddress: false),
              ASingleAddress(selectedAddress: true),
            ],
          ),
        ),
      ),
    );
  }
}
