import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/features/personalization/controllers/address_controller.dart';
import 'package:aurakart/features/personalization/screens/address/add_new_address.dart';
import 'package:aurakart/features/personalization/screens/address/widgets/single_address.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              // Use key to trigger refresh
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddress(),
              builder: (context, snapshot) {
                /// Helper Function Loader, No Record, OR ERROR MESSAGE
                final response = ACloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);

                if (response != null) return response;

                final addresses = snapshot.data!;
                
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (_, index) => ASingleAddress(
                    address: addresses[index],
                    onTap: () => controller.selectAddress(addresses[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
