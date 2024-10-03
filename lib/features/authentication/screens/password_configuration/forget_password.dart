import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/styles/spacing_styles.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Iconsax.arrow_left_copy)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(TImages.backgroundAuth),
              opacity: 0.1,
              fit: BoxFit.cover),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: TSpacingStyle.paddingWithAppbarHeight,
                child: Container(
                  margin: const EdgeInsets.only(top: TSizes.appBarHeight),
                  decoration: BoxDecoration(
                    color: TColors.white, // Warna latar belakang
                    borderRadius: BorderRadius.circular(10), // Bentuk border
                    boxShadow: [
                      BoxShadow(
                        color: TColors.darkGrey.withOpacity(
                            0.5), // Warna bayangan dan tingkat kejernihan
                        spreadRadius: 5, // Penyebaran bayangan
                        blurRadius: 7, // Tingkat kabur bayangan
                        offset: const Offset(
                            0, 3), // Perpindahan bayangan dari objek
                      ),
                    ],
                  ),
                  height: THelperFunctions.screenHeight() * 0.38,
                  width: THelperFunctions.screenWidth() * 0.45,
                  child: Form(
                    key: controller.forgetPasswordKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: TSizes.spaceAuthScreen - 30,
                          horizontal: TSizes.spaceAuthScreen),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "forgetPasswordTitle".tr,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          // Email
                          SizedBox(
                            height: TSizes.inputFieldHeight,
                            child: TextFormField(
                              controller: controller.email,
                              validator: (value) =>
                                  TValidator.validateEmail(value),
                              onTapOutside: (event) =>
                                  Focus.of(context).unfocus(),
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Iconsax.direct_copy),
                                  labelText: "email".tr),
                            ),
                          ),

                          const SizedBox(
                            height: TSizes.spaceBtwSections - 10,
                          ),

                          // Sign In Button
                          SizedBox(
                            width: double.infinity,
                            height: TSizes.inputFieldHeight,
                            child: ElevatedButton(
                              onPressed: () =>
                                  controller.sendPasswordResetEmail(),
                              child: Text(
                                "send".tr,
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
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: TSpacingStyle.paddingWithAppbarHeight,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: TSpacingStyle.paddingWithAppbarHeight,
                    child: SizedBox(
                      width: THelperFunctions.screenWidth() * 0.5,
                      child: Card(
                        color: TColors.white,
                        elevation: 2,
                        borderOnForeground: true,
                        child: Form(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: TSizes.spaceAuthScreen - 30,
                                horizontal: TSizes.spaceAuthScreen),
                            child: Column(
                              children: [
                                Text(
                                  "forgetPasswordTitle".tr,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwSections,
                                ),
                                // Email
                                TextFormField(
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          const Icon(Iconsax.direct_right),
                                      labelText: "email".tr),
                                ),

                                const SizedBox(
                                  height: TSizes.spaceBtwSections - 10,
                                ),

                                // Sign In Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "forgetPassword".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: TColors.white,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
