import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ABillingPaymentSection extends StatelessWidget {
  const ABillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        ASectionHeading(
          title: 'Payment Method',
          buttontitle: 'Change',
          onPressed: () {},
        ),
        
        const SizedBox(height: ASizes.spaceBtwItems / 2),

        Row(
          children: [
            ARoundedContainer(
              width: 68,
              height: 35,
              backgroundColor: darkMode ? AColors.light : AColors.white,
              padding: const EdgeInsets.all(ASizes.sm),
              child: const Image(
                image: AssetImage(AImages.paypal),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: ASizes.spaceBtwItems / 2),
            Text('Paypal', style: Theme.of(context).textTheme.bodyLarge),
          ],
        )
      ],
    );
  }
}
