import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/pick_image/pick_image_logo.dart';
import 'package:restaurant_bukuku/features/setting/controllers/setting_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class RestaurantData extends StatelessWidget {
  const RestaurantData({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Get.put(SettingController());
    return Form(
      key: settingController.formMerchantKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: TSizes.spaceBtwItems,
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
                controller: settingController.restaurantName,
                validator: (value) =>
                    TValidator.validateEmptyText("restaurantName".tr, value),
                style: const TextStyle()
                    .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
                onTapOutside: (value) => FocusScope.of(context).unfocus(),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
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
                  borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => settingController.mobileImage.value != null
                          ? Container(
                              width: 77,
                              height: 77,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(
                                        settingController.mobileImage.value!),
                                    fit: BoxFit.cover),
                                border:
                                    Border.all(width: 1, color: TColors.grey),
                                borderRadius: BorderRadius.circular(
                                    TSizes.inputFieldRadius),
                              ),
                            )
                          : settingController
                                  .merchantLogoActive.value.isNotEmpty
                              ? Container(
                                  width: 77,
                                  height: 77,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(settingController
                                            .merchantLogoActive.value),
                                        fit: BoxFit.cover),
                                    border: Border.all(
                                        width: 1, color: TColors.grey),
                                    borderRadius: BorderRadius.circular(
                                        TSizes.inputFieldRadius),
                                  ),
                                )
                              : Container(
                                  width: 77,
                                  height: 77,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: TColors.grey),
                                    borderRadius: BorderRadius.circular(
                                        TSizes.inputFieldRadius),
                                  ),
                                  child: Container(
                                    width: 77,
                                    height: 77,
                                    decoration: BoxDecoration(
                                      color: TColors.darkGrey,
                                      borderRadius: BorderRadius.circular(
                                          TSizes.inputFieldRadius),
                                    ),
                                  ),
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
                              const PickImageLogoSetting(),
                              false,
                            );
                          },
                          child: Text(
                              settingController.mobileImage.value == null
                                  ? "Ambil Gambar"
                                  : "Ganti Gambar"),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
        ],
      ),
    );
  }
}
