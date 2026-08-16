import 'package:flutter/material.dart';
import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/utils/constants/sizes.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(
        title: Text('Privacy Policy'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text(
              'Last updated: ${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: ASizes.spaceBtwSections),
            Text(
              '1. Introduction',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: ASizes.sm),
            Text(
              'Welcome to Dekozy. We respect your privacy and are committed to protecting your personal data. This privacy policy will inform you as to how we look after your personal data when you visit our application and tell you about your privacy rights and how the law protects you.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text(
              '2. The data we collect about you',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: ASizes.sm),
            Text(
              'Personal data, or personal information, means any information about an individual from which that person can be identified. We may collect, use, store and transfer different kinds of personal data about you which we have grouped together as follows:\n\n'
              '• Identity Data includes first name, maiden name, last name, username or similar identifier, marital status, title, date of birth and gender.\n'
              '• Contact Data includes billing address, delivery address, email address and telephone numbers.\n'
              '• Financial Data includes bank account and payment card details.\n'
              '• Transaction Data includes details about payments to and from you and other details of products and services you have purchased from us.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text(
              '3. How we use your personal data',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: ASizes.sm),
            Text(
              'We will only use your personal data when the law allows us to. Most commonly, we will use your personal data in the following circumstances:\n\n'
              '• Where we need to perform the contract we are about to enter into or have entered into with you.\n'
              '• Where it is necessary for our legitimate interests (or those of a third party) and your interests and fundamental rights do not override those interests.\n'
              '• Where we need to comply with a legal obligation.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: ASizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
