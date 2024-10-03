import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class OnBoardingDotNavigationTablet extends StatelessWidget {
  const OnBoardingDotNavigationTablet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return SmoothPageIndicator(
      controller: controller.pageController,
      onDotClicked: controller.dotNavigationClick,
      count: 3,
      effect: ExpandingDotsEffect(
          activeDotColor: dark ? TColors.light : TColors.dark, dotHeight: 6),
    );
  }
}
