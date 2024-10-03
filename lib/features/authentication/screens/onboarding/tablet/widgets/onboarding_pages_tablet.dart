import 'package:flutter/material.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPageImageTablet extends StatelessWidget {
  const OnBoardingPageImageTablet({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(image,
              height: THelperFunctions.screenHeight() * 0.6,
              fit: BoxFit.fitHeight),
        ],
      ),
    );
  }
}
