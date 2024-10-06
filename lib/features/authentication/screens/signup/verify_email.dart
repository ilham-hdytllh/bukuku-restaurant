import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';

// ignore: must_be_immutable
class VerifyEmailScreen extends StatelessWidget {
  VerifyEmailScreen({super.key, this.email});

  String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Iconsax.arrow_left_copy)),
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
                    image: const AssetImage(TImages.deliveredEmailIllustration),
                    height: THelperFunctions.screenWidth() * 0.3,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  // Title & SubTitle
                  Text(
                    "confirmEmail".tr,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Text(
                    "support@bukuku.com",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Text(
                    "confirmEmailSubTitle".tr,
                    style: Theme.of(context).textTheme.bodyMedium!,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  SizedBox(
                    height: 35,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => controller.sendEmailVerification(),
                      child: Text(
                        "resendEmail".tr,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            color: TColors.primary,
                            fontWeight: FontWeight.w600),
                      ),
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
