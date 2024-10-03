import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/dial_code_dropdown/dial_code_dropdown.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/signup/signup_controller.dart';
import 'package:restaurant_bukuku/features/authentication/screens/signup/widgets/terms_conditions_checkbox_tablet.dart';
import 'package:restaurant_bukuku/features/system/controller/dialcode/dialcode_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class TFormSignup extends StatelessWidget {
  const TFormSignup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final dialcodeController = Get.put(DialCodeController());
    final controller = Get.put(SignupController(), permanent: true);
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
          key: controller.signupFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: TSizes.spaceAuthScreen - 30,
                horizontal: TSizes.spaceAuthScreen),
            child: Column(
              children: [
                Text(
                  "signupTitle".tr,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                // Username
                SizedBox(
                  child: TextFormField(
                    style: const TextStyle().copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.normal),
                    onTapOutside: (value) => FocusScope.of(context).unfocus(),
                    validator: (value) =>
                        TValidator.validateEmptyText("Username", value),
                    controller: controller.username,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.user_edit_copy),
                        labelText: "username".tr),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),

                // Email
                SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle().copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.normal),
                    onTapOutside: (value) => FocusScope.of(context).unfocus(),
                    validator: (value) => TValidator.validateEmail(value),
                    controller: controller.email,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.direct_copy),
                        labelText: "email".tr),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),

                // Phone Number
                SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle().copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.normal),
                    onTapOutside: (value) => FocusScope.of(context).unfocus(),
                    validator: (value) => TValidator.validatePhoneNumber(value),
                    controller: controller.phoneNumber,
                    decoration: InputDecoration(
                      prefixIcon: GestureDetector(
                        onTap: () {
                          CustomDialog.tabletDialog(
                            (THelperFunctions.screenWidth() * 0.5),
                            () {
                              dialcodeController.codePhoneString.value =
                                  dialcodeController
                                      .selectedCodePhoneString.value;
                              Get.back();
                            },
                            "save".tr,
                            "Pilih Code Telepon",
                            const ContentGetDialCode(),
                            true,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 60,
                          decoration: BoxDecoration(
                              color: TColors.softGrey,
                              border: Border.all(
                                  width: 1, color: TColors.borderPrimary),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5))),
                          child: Center(
                            child: Obx(
                              () => Text(
                                dialcodeController.codePhoneString.value,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),

                // Password
                Obx(
                  () => SizedBox(
                    child: TextFormField(
                      style: const TextStyle().copyWith(
                          fontSize: 14.0, fontWeight: FontWeight.normal),
                      onTapOutside: (value) => FocusScope.of(context).unfocus(),
                      validator: (value) => TValidator.validatePassword(value),
                      controller: controller.password,
                      obscureText: controller.hidePassword.value,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check_copy),
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                                  !controller.hidePassword.value,
                              icon: Icon(controller.hidePassword.value
                                  ? Iconsax.eye_slash_copy
                                  : Iconsax.eye_copy)),
                          labelText: "password".tr),
                    ),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections - 20,
                ),

                // Terms&Conditions Checkbox
                const TTermsAndConditionCheckbox(),

                const SizedBox(
                  height: TSizes.spaceBtwSections - 20,
                ),

                // Signup Button
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: TSizes.inputFieldHeight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                controller.privacyPolicy.value == false
                                    ? TColors.darkGrey
                                    : TColors.primary),
                        onPressed: controller.privacyPolicy.value == false
                            ? () {}
                            : () => controller.singupWithEmailPassword(),
                        child: Text(
                          "createAccount".tr,
                        )),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
