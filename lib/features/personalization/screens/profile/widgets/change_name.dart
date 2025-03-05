import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/features/personalization/controllers/update_name_controller.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:aurakart/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());

    return Scaffold(
      /// Appbar
      appBar: AAppBar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      // Body
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(
              'Use real name for easy verification. This name will apppear on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: ASizes.spaceBtwSections),

            /// Text field and button
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        AValidator.validateEmptyText('First name', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: ATexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: ASizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        AValidator.validateEmptyText('Last name', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: ATexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
