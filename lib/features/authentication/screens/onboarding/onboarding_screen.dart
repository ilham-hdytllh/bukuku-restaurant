import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/features/authentication/screens/onboarding/mobile/onboarding_mobile.dart';
import 'package:restaurant_bukuku/features/authentication/screens/onboarding/tablet/onboarding_tablet.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape) {
          return const SizedBox(
            child: OnBoardingScreenTablet(), // Tablet layout
          );
        } else {
          return const SizedBox(
            child: OnBoardingScreenMobile(), // Tablet layout
          );
        }
      },
    );
  }
}
