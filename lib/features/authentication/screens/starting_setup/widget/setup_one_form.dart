import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/address_from_maps/pick_address.dart';
import 'package:restaurant_bukuku/common/widgets/currency_dropdown/get_currency_widget.dart';
import 'package:restaurant_bukuku/common/widgets/pick_image/pick_image.dart';
import 'package:restaurant_bukuku/features/system/controller/address_from_map/address_from_map.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/starting_setup/starting_setup_controller.dart';
import 'package:restaurant_bukuku/features/authentication/screens/starting_setup/widget/starting_setup_next_button.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class SetupFormOne extends StatelessWidget {
  const SetupFormOne({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StartingSetupController());
    final addressFromMapController = Get.put(AddressFromMapController());
    return Form(
      key: controller.formSetupOne,
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
                "stepperOneTitle".tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems - 10,
            ),
            Text(
              "stepperOneSubtitle".tr,
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
                        color: TColors.darkerGrey),
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
                        text: "restaurantName".tr,
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
                  controller: controller.restaurantName,
                  validator: (value) =>
                      TValidator.validateEmptyText("restaurantName".tr, value),
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
                        text: "restaurantAddress".tr,
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
                Obx(
                  () => TextFormField(
                    readOnly: true,
                    onTap: () {
                      Get.to(const PickerAdress());
                    },
                    controller: addressFromMapController.addressFromMap.value,
                    validator: (value) => TValidator.validateEmptyText(
                        "restaurantAddress".tr, value),
                    style: const TextStyle().copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.normal),
                    onTapOutside: (value) => FocusScope.of(context).unfocus(),
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
                        text: "currencyFormat".tr,
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
                  controller: controller.restaurantCurrency,
                  readOnly: true,
                  onTap: () {
                    CustomDialog.tabletDialog(
                        (THelperFunctions.screenWidth() * 0.5), () {
                      controller.restaurantCurrency.text =
                          controller.selectedCurrencyFormatString.value;

                      controller.currencyFormatString.value =
                          controller.selectedCurrencyFormatString.value;
                      Get.back();
                    }, "save".tr, "selectCurrency".tr,
                        const ContentGetCurrency(), true);
                  },
                  style: const TextStyle()
                      .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
                  onTapOutside: (value) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.arrow_drop_down),
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
                        text: "restaurantLogo".tr,
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
                        controller.mobileImage.value == null
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
                                          controller.mobileImage.value!),
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
                                "Ambil gambar untuk jadi logo restoran anda (opsional)",
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
                                  const PickImageLogo(),
                                  false,
                                );
                              },
                              child: Text(controller.mobileImage.value == null
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                    text: TextSpan(
                        text: "restaurantType".tr,
                        style: Theme.of(context).textTheme.titleLarge,
                        children: [
                      TextSpan(
                          text: ' (Maks 2)*',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: TColors.primary))
                    ])),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields - 8,
                ),
                ListView.builder(
                  padding: const EdgeInsets.only(left: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.restaurantTypeData.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 45,
                      child: Obx(
                        () => CheckboxListTile(
                          side: const BorderSide(
                              width: 1, color: TColors.primary),
                          contentPadding: const EdgeInsets.all(0),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            controller.restaurantTypeData[index],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          value: controller.restaurantType
                              .contains(controller.restaurantTypeData[index]),
                          onChanged: (value) {
                            if (controller.restaurantType.contains(
                                    controller.restaurantTypeData[index]) ==
                                false) {
                              // validation cannot < 2
                              if (controller.restaurantType.length < 2) {
                                // add to list restaurant type
                                controller.restaurantType
                                    .add(controller.restaurantTypeData[index]);
                              } else {
                                null;
                              }
                            } else {
                              // remove form list if contains
                              controller.restaurantType
                                  .remove(controller.restaurantTypeData[index]);
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const StartingSetupNextButton(),
          ],
        ),
      ),
    );
  }
}
