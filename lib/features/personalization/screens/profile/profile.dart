import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/images/circular_image.dart';
import 'package:aurakart/common/widgets/texts/section_heading.dart';
import 'package:aurakart/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: const AAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
    
      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    // Image
                    const ACircularImage(
                      image: AImages.user,
                      width: 80,
                      height: 80,
                    ),
    
                    // Button
                    TextButton(
                      onPressed: () {},
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),
    
              const SizedBox(height: ASizes.spaceBtwItems / 2),
    
              const Divider(),
    
              const SizedBox(height: ASizes.spaceBtwItems),
    
              /// Details
              const ASectionHeading(
                title: 'Personal Information',
                showActionbutton: false,
              ),
    
              const SizedBox(height: ASizes.spaceBtwItems),
    
              /// Heading Personal Info
              AProfileMenu(
                title: 'User ID',
                value: '45689',
                icon: Iconsax.copy,
                onPressed: () {},
              ),
    
              AProfileMenu(
                title: 'E-mail',
                value: 'support@aurakart.com',
                onPressed: () {},
              ),
    
              AProfileMenu(
                title: 'Phone Number',
                value: '+91-3178059528',
                onPressed: () {},
              ),
    
              AProfileMenu(
                title: 'Gender',
                value: 'Male',
                onPressed: () {},
              ),
    
              AProfileMenu(
                title: 'Date of Birth',
                value: '18 Oct, 2000',
                onPressed: () {},
              ),
    
              const SizedBox(height: ASizes.spaceBtwItems),
    
              const Divider(),
    
              const SizedBox(height: ASizes.spaceBtwItems),
    
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
