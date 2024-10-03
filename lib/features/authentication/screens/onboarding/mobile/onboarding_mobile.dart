import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:restaurant_bukuku/features/authentication/screens/onboarding/mobile/widgets/onboarding_dot_navigation_mobile.dart';
import 'package:restaurant_bukuku/features/authentication/screens/onboarding/mobile/widgets/onboarding_next_button_mobile.dart';
import 'package:restaurant_bukuku/features/authentication/screens/onboarding/mobile/widgets/onboarding_pages_mobile.dart';
import 'package:restaurant_bukuku/features/authentication/screens/onboarding/mobile/widgets/onboarding_skip_mobile.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';

class OnBoardingScreenMobile extends StatelessWidget {
  const OnBoardingScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Horizontal scrollable pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPageMobile(
                image: TImages.onBoardingImage1,
                title: "onBoardingTitle1".tr,
                subTitle: "onBoardingSubTitle1".tr,
              ),
              OnBoardingPageMobile(
                image: TImages.onBoardingImage2,
                title: "onBoardingTitle2".tr,
                subTitle: "onBoardingSubTitle2".tr,
              ),
              OnBoardingPageMobile(
                image: TImages.onBoardingImage3,
                title: "onBoardingTitle3".tr,
                subTitle: "onBoardingSubTitle3".tr,
              ),
            ],
          ),
          // Skip button
          const OnBoardingSkipMobile(),
          // Dot navigation page indicator
          const OnBoardingDotNavigationMobile(),
          // Circular button
          const OnBoardingNextButtonMobile()
        ],
      ),
    );
  }
}
