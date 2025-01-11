import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/features/personalization/controllers/address_controller.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressscreen extends StatelessWidget {
  const AddNewAddressscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      // Appbar
      appBar: const AAppBar(
        showBackArrow: true,
        title: Text('Add new Address'),
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Form(
            key: controller.addressFormkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      AValidator.validateEmptyText('Name', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                ),

                const SizedBox(height: ASizes.spaceBtwInputFields),

                // Phone
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: AValidator.validatePhoneNumber,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                  ),
                ),

                const SizedBox(height: ASizes.spaceBtwInputFields),

                Row(
                  children: [
                    // Street
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) =>
                            AValidator.validateEmptyText('Street', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'Street',
                        ),
                      ),
                    ),

                    const SizedBox(width: ASizes.spaceBtwInputFields),

                    // Postal Code
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) =>
                            AValidator.validateEmptyText('Postal Code', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: ASizes.spaceBtwInputFields),

                Row(
                  children: [
                    // City
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) =>
                            AValidator.validateEmptyText('City', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City',
                        ),
                      ),
                    ),

                    const SizedBox(width: ASizes.spaceBtwInputFields),

                    // State
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) =>
                            AValidator.validateEmptyText('State', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: 'State',
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: ASizes.spaceBtwInputFields),

                // Country
                TextFormField(
                  controller: controller.country,
                  validator: (value) =>
                      AValidator.validateEmptyText('Country', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country',
                  ),
                ),

                const SizedBox(height: ASizes.defaultSpace),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
