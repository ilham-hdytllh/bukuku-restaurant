import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/features/authentication/controllers/starting_setup/starting_setup_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';

class ContentGetCurrency extends StatelessWidget {
  const ContentGetCurrency({super.key});

  @override
  Widget build(BuildContext context) {
    final StartingSetupController controller =
        Get.put(StartingSetupController());

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
                controller: controller.searchCurrencyCode.value,
                decoration: InputDecoration(
                  suffixIcon:
                      controller.searchCurrencyCode.value.text.isNotEmpty
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
              thumbVisibility: true,
              trackVisibility: true,
              thickness: 8,
              interactive: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.filteredCurrencyCodeData.length,
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
                            controller.filteredCurrencyCodeData[index]
                                ["currency_code"],
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                      value: controller.filteredCurrencyCodeData[index]
                          ["currency_code"],
                      groupValue: controller.selectedCurrencyFormatString.value,
                      activeColor: TColors.primary,
                      controlAffinity: ListTileControlAffinity.trailing,
                      onChanged: (value) {
                        controller.selectedCurrencyFormatString.value =
                            controller.filteredCurrencyCodeData[index]
                                ["currency_code"];
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
