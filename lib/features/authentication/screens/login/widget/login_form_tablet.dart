import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/login/login_controller.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final isDark = THelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: isDark ? TColors.black : TColors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10), // Bentuk border
        boxShadow: [
          BoxShadow(
            color: TColors.darkGrey
                .withOpacity(0.5), // Warna bayangan dan tingkat kejernihan
            spreadRadius: 5, // Penyebaran bayangan
            blurRadius: 7, // Tingkat kabur bayangan
            offset: const Offset(0, 3), // Perpindahan bayangan dari objek
          ),
        ],
      ),
      width: THelperFunctions.screenWidth() < 900
          ? THelperFunctions.screenWidth() * 0.6
          : THelperFunctions.screenWidth() * 0.45,
      child: Form(
        key: controller.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: TSizes.spaceAuthScreen - 30,
              horizontal: TSizes.spaceAuthScreen),
          child: Column(
            children: [
              Text(
                "loginTitle".tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                "loginSubTitle".tr,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              // Email
              Container(
                constraints: const BoxConstraints(
                  minHeight: TSizes.inputFieldHeight,
                  maxHeight: TSizes.inputFieldHeight + 25,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.email,
                  validator: (value) => TValidator.validateEmail(value),
                  style: const TextStyle()
                      .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
                  onTapOutside: (value) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.direct_copy),
                      labelText: "email".tr),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              // Password
              Obx(
                () => Container(
                  constraints: const BoxConstraints(
                    minHeight: TSizes.inputFieldHeight,
                    maxHeight: TSizes.inputFieldHeight + 25,
                  ),
                  child: TextFormField(
                    controller: controller.password,
                    validator: (value) => TValidator.validatePassword(value),
                    style: const TextStyle().copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.normal),
                    onTapOutside: (value) => FocusScope.of(context).unfocus(),
                    obscureText: controller.hidePassword.value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check_copy),
                      labelText: "password".tr,
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value == true
                            ? Iconsax.eye_slash_copy
                            : Iconsax.eye_copy),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections - 20,
              ),
              // Remember Me & Forgot Pw
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Remember Me
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value,
                        ),
                      ),
                      Text(
                        "rememberMe".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  // Forget Pw
                  TextButton(
                    onPressed: () => Get.to(
                      () => const ForgetPasswordScreen(),
                    ),
                    // onPressed: () => Get.to(
                    //   () => const SelectAccountScreen(),
                    // ),
                    child: Text(
                      "forgetPassword".tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: TColors.primary),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections - 20,
              ),

              // Sign In Button
              SizedBox(
                width: double.infinity,
                height: TSizes.inputFieldHeight,
                child: ElevatedButton(
                  onPressed: () => controller.emailAndPasswordLogin(),
                  child: Text(
                    "signIn".tr,
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
