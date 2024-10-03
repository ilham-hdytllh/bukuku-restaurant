import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:restaurant_bukuku/features/authentication/screens/onboarding/tablet/widgets/onboarding_dot_navigation_tablet.dart';
import 'package:restaurant_bukuku/features/authentication/screens/onboarding/tablet/widgets/onboarding_next_button_tablet.dart';
import 'package:restaurant_bukuku/features/authentication/screens/onboarding/tablet/widgets/onboarding_pages_tablet.dart';
import 'package:restaurant_bukuku/features/authentication/screens/onboarding/tablet/widgets/onboarding_skip_tablet.dart';
import 'package:restaurant_bukuku/features/authentication/screens/onboarding/tablet/widgets/onboarding_text_tablet.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class OnBoardingScreenTablet extends StatelessWidget {
  const OnBoardingScreenTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Builder(builder: (context) {
      return Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            // Horizontal scrollable pages
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OnBoardingPageTextTablet(
                              title: "onBoardingTitle1".tr,
                              subTitle: "onBoardingSubTitle1".tr),
                          const SizedBox(
                            height: TSizes.spaceBtwSections + 60,
                          ),
                          // Dot navigation page indicator
                          const OnBoardingDotNavigationTablet(),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          // Circular button
                          const OnBoardingNextButtonTablet()
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: TSizes.defaultSpace,
                    ),
                    const Expanded(
                      child: OnBoardingPageImageTablet(
                        image: TImages.onBoardingImage1,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OnBoardingPageTextTablet(
                              title: "onBoardingTitle2".tr,
                              subTitle: "onBoardingSubTitle2".tr),
                          const SizedBox(
                            height: TSizes.spaceBtwSections + 60,
                          ),
                          // Dot navigation page indicator
                          const OnBoardingDotNavigationTablet(),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          // Circular button
                          const OnBoardingNextButtonTablet()
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: TSizes.defaultSpace,
                    ),
                    const Expanded(
                      child: OnBoardingPageImageTablet(
                        image: TImages.onBoardingImage2,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OnBoardingPageTextTablet(
                              title: "onBoardingTitle3".tr,
                              subTitle: "onBoardingSubTitle3".tr),
                          const SizedBox(
                            height: TSizes.spaceBtwSections + 60,
                          ),
                          // Dot navigation page indicator
                          const OnBoardingDotNavigationTablet(),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          // Circular button
                          const OnBoardingNextButtonTablet()
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: TSizes.defaultSpace,
                    ),
                    const Expanded(
                      child: OnBoardingPageImageTablet(
                        image: TImages.onBoardingImage3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Skip button
            const OnBoardingSkipTablet(),
          ],
        ),
      );
    });
  }
}
