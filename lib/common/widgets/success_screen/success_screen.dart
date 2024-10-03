import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: SizedBox(
          width: THelperFunctions.screenWidth() < 900
              ? THelperFunctions.screenWidth() * 0.6
              : THelperFunctions.screenWidth() * 0.45,
          height: double.infinity,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage(TImages.backgroundAuth),
          //       opacity: 0.1,
          //       fit: BoxFit.cover),
          // ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Image
                  Image(
                    image: const AssetImage(TImages.verifyIllustration),
                    height: THelperFunctions.screenWidth() * 0.3,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  // Title & SubTitle
                  Text(
                    title.tr,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Text(
                    subTitle.tr,
                    style: Theme.of(context).textTheme.bodyMedium!,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  // Button
                  SizedBox(
                    height: TSizes.inputFieldHeight,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => onPressed(),
                      child: Text("next".tr),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
