import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/address_from_maps/pick_address.dart';
import 'package:restaurant_bukuku/common/widgets/custom_outlined_button/custom_outlined_button.dart';
import 'package:restaurant_bukuku/features/setting/controllers/setting_controller.dart';
import 'package:restaurant_bukuku/features/system/controller/address_from_map/address_from_map.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class BranchAddress extends StatelessWidget {
  const BranchAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final addressFromMapController = Get.put(AddressFromMapController());
    final settingController = Get.put(SettingController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
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
          () => Text(
            addressFromMapController.address.value.isEmpty
                ? settingController.branchAddressActive.value
                : addressFromMapController.address.value,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: TColors.black,
                ),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        GestureDetector(
          onTap: () {
            Get.to(const PickerAdress());
          },
          child: CustomOutlinedButton(
            borderColor: TColors.primary,
            height: TSizes.inputFieldHeight,
            child: Text(
              "Change Pin Point",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: TColors.black,
                  ),
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
      ],
    );
  }
}
