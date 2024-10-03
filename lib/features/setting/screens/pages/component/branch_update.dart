import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/features/setting/controllers/setting_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class BranchProfileUpdate extends StatelessWidget {
  const BranchProfileUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Get.put(SettingController());
    return Form(
      key: settingController.formBranchKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          RichText(
              text: TextSpan(
                  text: "Branch Name",
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
            keyboardType: TextInputType.text,
            controller: settingController.branchName,
            validator: (value) =>
                TValidator.validateEmptyText("Branch name", value),
            style: const TextStyle()
                .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
            onTapOutside: (value) => FocusScope.of(context).unfocus(),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          RichText(
              text: TextSpan(
                  text: "Branch Phone Number",
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
            keyboardType: TextInputType.text,
            controller: settingController.branchPhoneNumber,
            validator: (value) =>
                TValidator.validateEmptyText("Branch Phone Number", value),
            decoration: InputDecoration(
              prefixIcon: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 60,
                decoration: BoxDecoration(
                    color: TColors.softGrey,
                    border: Border.all(width: 1, color: TColors.borderPrimary),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5))),
                child: Center(
                  child: Obx(
                    () => Text(
                      settingController.branchDialCodeActive.value,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ),
            style: const TextStyle()
                .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal),
            onTapOutside: (value) => FocusScope.of(context).unfocus(),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
        ],
      ),
    );
  }
}
