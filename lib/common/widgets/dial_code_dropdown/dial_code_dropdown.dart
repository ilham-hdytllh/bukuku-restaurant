import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/system/controller/dialcode/dialcode_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class ContentGetDialCode extends StatelessWidget {
  const ContentGetDialCode({super.key});

  @override
  Widget build(BuildContext context) {
    final DialCodeController controller = Get.put(DialCodeController());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: TSizes.inputFieldHeight,
            child: Obx(
              () => TextFormField(
                onChanged: (value) => controller.orderBySearch(),
                controller: controller.searchDialCode.value,
                decoration: InputDecoration(
                  suffixIcon: controller.searchDialCode.value.text.isNotEmpty
                      ? IconButton(
                          onPressed: () => controller.resetSearch(),
                          icon: const Icon(Iconsax.trash),
                        )
                      : null,
                  border: const OutlineInputBorder().copyWith(
                    borderRadius:
                        BorderRadius.circular(TSizes.inputFieldRadius),
                    borderSide:
                        const BorderSide(width: 1, color: TColors.darkGrey),
                  ),
                  enabledBorder: const OutlineInputBorder().copyWith(
                    borderRadius:
                        BorderRadius.circular(TSizes.inputFieldRadius),
                    borderSide:
                        const BorderSide(width: 1, color: TColors.darkGrey),
                  ),
                  focusedBorder: const OutlineInputBorder().copyWith(
                    borderRadius:
                        BorderRadius.circular(TSizes.inputFieldRadius),
                    borderSide:
                        const BorderSide(width: 1, color: TColors.primary),
                  ),
                ),
                style: const TextStyle()
                    .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
                onTapOutside: (value) => FocusScope.of(Get.context!).unfocus(),
              ),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => Scrollbar(
              thumbVisibility: false,
              trackVisibility: false,
              thickness: 8,
              interactive: true,
              radius: const Radius.circular(5),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.filteredDialCodeData.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => RadioListTile(
                      contentPadding: const EdgeInsets.only(right: 5, left: 5),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${controller.filteredDialCodeData[index]["dial_code"]} (${controller.filteredDialCodeData[index]["countries"]})",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                      value: controller.filteredDialCodeData[index]
                          ["dial_code"],
                      groupValue: controller.selectedCodePhoneString.value,
                      activeColor: TColors.primary,
                      controlAffinity: ListTileControlAffinity.trailing,
                      onChanged: (value) {
                        controller.selectedCodePhoneString.value =
                            controller.filteredDialCodeData[index]["dial_code"];
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
