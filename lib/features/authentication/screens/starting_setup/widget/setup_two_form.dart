import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/pick_image/pick_image_menu.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/starting_setup/starting_setup_controller.dart';
import 'package:restaurant_bukuku/features/authentication/screens/starting_setup/widget/starting_setup_next_button.dart';
import 'package:restaurant_bukuku/features/authentication/screens/starting_setup/widget/starting_setup_previous_button.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class SetupFormTwo extends StatelessWidget {
  const SetupFormTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StartingSetupController());
    return Form(
      key: controller.formSetupTwo,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: TSizes.spaceAuthScreen - 30,
            horizontal: TSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "stepperTwoTitle".tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems - 10,
            ),
            Text(
              "stepperTwoSubtitle".tr,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: TColors.primary),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: TColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                    text: TextSpan(
                        text: "menuName".tr,
                        style: Theme.of(context).textTheme.titleLarge,
                        children: [
                      TextSpan(
                          text: ' *',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: TColors.primary))
                    ])),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields - 8,
                ),
                TextFormField(
                  controller: controller.menuName,
                  validator: (value) =>
                      TValidator.validateEmptyText("menuName".tr, value),
                  style: const TextStyle()
                      .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
                  onTapOutside: (value) => FocusScope.of(context).unfocus(),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems - 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                    text: TextSpan(
                        text: "menuPrice".tr,
                        style: Theme.of(context).textTheme.titleLarge,
                        children: [
                      TextSpan(
                          text: ' *',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: TColors.primary))
                    ])),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields - 8,
                ),
                TextFormField(
                  controller: controller.menuPrice,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      TValidator.validateEmptyText("menuPrice".tr, value),
                  style: const TextStyle()
                      .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
                  onTapOutside: (value) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 60,
                      decoration: const BoxDecoration(
                          color: TColors.grey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5))),
                      child: Center(
                        child: Obx(
                          () => Text(
                            controller.currencyFormatString.value,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems - 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                    text: TextSpan(
                        text: "menuPhotoOptional".tr,
                        style: Theme.of(context).textTheme.titleLarge,
                        children: [
                      TextSpan(
                          text: '',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: TColors.primary))
                    ])),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields - 8,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: TColors.grey),
                    borderRadius:
                        BorderRadius.circular(TSizes.inputFieldRadius),
                  ),
                  child: Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller.mobileImageMenu.value == null
                            ? Container(
                                width: 77,
                                height: 77,
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: TColors.grey),
                                  borderRadius: BorderRadius.circular(
                                      TSizes.inputFieldRadius),
                                ),
                                child: Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    color: TColors.darkGrey,
                                    borderRadius: BorderRadius.circular(
                                        TSizes.inputFieldRadius),
                                  ),
                                ),
                              )
                            : Container(
                                width: 77,
                                height: 77,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(
                                          controller.mobileImageMenu.value!),
                                      fit: BoxFit.cover),
                                  border:
                                      Border.all(width: 1, color: TColors.grey),
                                  borderRadius: BorderRadius.circular(
                                      TSizes.inputFieldRadius),
                                ),
                              ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              child: Text(
                                "Ambil gambar untuk jadi gambar menu pertama anda.",
                                textAlign: TextAlign.start,
                              ),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields - 8,
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: TColors.darkGrey),
                                padding: const EdgeInsets.symmetric(
                                    vertical: TSizes.buttonHeight - 10,
                                    horizontal: 20),
                              ),
                              onPressed: () {
                                CustomDialog.tabletDialog(
                                  (THelperFunctions.screenWidth() * 0.5),
                                  () {
                                    Get.back();
                                  },
                                  "save".tr,
                                  "Ambil Gambar",
                                  PickImageMenu(
                                    onTap1: () {
                                      controller.getMenuImageFromGallery();
                                    },
                                    onTap2: () {
                                      controller.getMenuImageFromGallery();
                                    },
                                  ),
                                  false,
                                );
                              },
                              child: Text(
                                  controller.mobileImageMenu.value == null
                                      ? "Ambil Gambar"
                                      : "Ganti Gambar"),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems - 8,
            ),
            const StartingSetupNextButton(),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            const StartingSetupPreviousButton(),
          ],
        ),
      ),
    );
  }
}
