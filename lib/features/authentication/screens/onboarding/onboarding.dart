import 'package:aurakart/features/authentication/controllers/onboading/onboarding_controller.dart';
import 'package:aurakart/features/authentication/screens/onboarding/widgets/dot_navigation.dart';
import 'package:aurakart/features/authentication/screens/onboarding/widgets/next_button.dart';
import 'package:aurakart/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:aurakart/features/authentication/screens/onboarding/widgets/skip_button.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          // Horizontal Scrollable Images
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: AImages.onBoardingImage1,
                title: ATexts.onBoardingTitlel,
                subTitle: ATexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: AImages.onBoardingImage2,
                title: ATexts.onBoardingTitle2,
                subTitle: ATexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: AImages.onBoardingImage3,
                title: ATexts.onBoardingTitle3,
                subTitle: ATexts.onBoardingSubTitle3,
              ),
            ],
          ),
    
          // Skip Button
          const OnBoardingSkip(),
    
          // Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),
    
          // Circular Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
