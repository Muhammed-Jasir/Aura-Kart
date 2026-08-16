import 'package:flutter/material.dart';
import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/utils/constants/sizes.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(
        title: Text('Terms of Use'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms of Use',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text(
              'Last updated: ${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: ASizes.spaceBtwSections),
            Text(
              '1. Acceptance of Terms',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: ASizes.sm),
            Text(
              'By accessing or using the Dekozy application, you agree to be bound by these Terms of Use and all applicable laws and regulations. If you do not agree with any part of these terms, you may not use our service.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text(
              '2. User Accounts',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: ASizes.sm),
            Text(
              'When you create an account with us, you must provide accurate, complete, and current information at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account on our Service.\n\n'
              'You are responsible for safeguarding the password that you use to access the Service and for any activities or actions under your password.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text(
              '3. Intellectual Property',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: ASizes.sm),
            Text(
              'The Service and its original content, features, and functionality are and will remain the exclusive property of Dekozy and its licensors. The Service is protected by copyright, trademark, and other laws of both the United States and foreign countries.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text(
              '4. Purchases',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: ASizes.sm),
            Text(
              'If you wish to purchase any product or service made available through the Service ("Purchase"), you may be asked to supply certain information relevant to your Purchase including, without limitation, your credit card number, the expiration date of your credit card, your billing address, and your shipping information.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: ASizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
