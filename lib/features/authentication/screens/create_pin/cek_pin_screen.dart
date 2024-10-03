import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/pin/create_pin_controllers.dart';
import 'package:restaurant_bukuku/features/employe/controller/employes/employee_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:pinput/pinput.dart';

class CekPinScreen extends StatelessWidget {
  const CekPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PinController());
    final employeController = Get.put(
      EmployeController(),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Iconsax.arrow_left_copy,
            )),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: SizedBox(
          width: THelperFunctions.screenWidth() < 900
              ? THelperFunctions.screenWidth() * 0.6
              : THelperFunctions.screenWidth() * 0.45,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Obx(
                () => Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ), // Title & SubTitle
                    Text(
                      employeController.selectedEmployeName.value,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    Text(
                      employeController.selectedEmployeRole.value
                          .toString()
                          .capitalizeSingle(),
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems * 2,
                    ),
                    // PIN Input
                    Obx(
                      () => Pinput(
                        controller: controller.pinController.value,
                        length: 5,
                        defaultPinTheme: PinTheme(
                          constraints: const BoxConstraints(
                              minWidth: 700, maxWidth: 700),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: 85,
                          height: 90,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            color: TColors.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.transparent),
                          ),
                        ),
                        obscuringCharacter: "*",
                        obscureText: controller.hiddenPIN.value,
                        onTapOutside: (value) =>
                            FocusScope.of(context).unfocus(),
                        autofocus: true,
                        focusedPinTheme: PinTheme(
                          constraints: const BoxConstraints(
                              minWidth: 700, maxWidth: 700),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: 85,
                          height: 90,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            color: TColors.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.transparent),
                          ),
                        ).copyWith(
                          decoration: PinTheme(
                            constraints: const BoxConstraints(
                                minWidth: 700, maxWidth: 700),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: 85,
                            height: 90,
                            textStyle: const TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                            decoration: BoxDecoration(
                              color: TColors.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.transparent),
                            ),
                          ).decoration!.copyWith(
                                border: Border.all(color: TColors.primary),
                              ),
                        ),
                        onCompleted: (pin) => controller.pinValidation(pin),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems * 2,
                    ),

                    SizedBox(
                      height: 35,
                      width: double.infinity,
                      child: Obx(
                        () => TextButton(
                          onPressed: () => controller.hiddenPIN.value =
                              !controller.hiddenPIN.value,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                controller.hiddenPIN.value == true
                                    ? Iconsax.eye_slash_copy
                                    : Iconsax.eye_copy,
                                size: TSizes.iconSm,
                                color: TColors.primary,
                              ),
                              const SizedBox(
                                width: TSizes.spaceBtwText,
                              ),
                              Text(
                                controller.hiddenPIN.value == true
                                    ? "Show Pin"
                                    : "Hidden Pin",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 14,
                                        color: TColors.primary,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
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
    );
  }
}
