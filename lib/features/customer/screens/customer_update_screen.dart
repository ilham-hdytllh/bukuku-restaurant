import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/city_content/city_content.dart';
import 'package:restaurant_bukuku/common/widgets/dial_code_dropdown/dial_code_dropdown.dart';
import 'package:restaurant_bukuku/common/widgets/district_content/district_content.dart';
import 'package:restaurant_bukuku/common/widgets/province_content/province_content.dart';
import 'package:restaurant_bukuku/features/customer/controllers/customer_controller.dart';
import 'package:restaurant_bukuku/features/system/controller/dialcode/dialcode_controller.dart';
import 'package:restaurant_bukuku/features/system/controller/pick_date/pick_date_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class UpdateCustomerScreen extends StatelessWidget {
  const UpdateCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dialcodeController = Get.put(DialCodeController());
    final customerController = Get.put(CustomerController());
    final pickDateController = Get.put(PickDateController());

    return Scaffold(
      backgroundColor: TColors.softGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: customerController.customerFormKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () => Get.back(id: 8),
                      icon: const Icon(
                        Iconsax.arrow_left_copy,
                        size: 28,
                        color: TColors.primary,
                      )),
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: TColors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: "customerName".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
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
                                  controller: customerController.customerName,
                                  validator: (value) =>
                                      TValidator.validateEmptyText(
                                          "customerName".tr, value),
                                  decoration: const InputDecoration(
                                      hintText: "Ex: Ferik Helix"),
                                  style: const TextStyle().copyWith(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                  onTapOutside: (value) =>
                                      FocusScope.of(context).unfocus(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: "phoneNo".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
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
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle().copyWith(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                  onTapOutside: (value) =>
                                      FocusScope.of(context).unfocus(),
                                  controller: customerController.phoneNumber,
                                  decoration: InputDecoration(
                                    hintText: "Ex : 81xxxxxxxxx",
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        CustomDialog.tabletDialog(
                                          (THelperFunctions.screenWidth() *
                                              0.5),
                                          () {
                                            dialcodeController
                                                    .codePhoneString.value =
                                                dialcodeController
                                                    .selectedCodePhoneString
                                                    .value;
                                            Get.back();
                                          },
                                          "save".tr,
                                          "selectPhoneCode".tr,
                                          const ContentGetDialCode(),
                                          true,
                                        );
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: TColors.softGrey,
                                            border: Border.all(
                                                width: 1,
                                                color: TColors.borderPrimary),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5))),
                                        child: Center(
                                          child: Obx(
                                            () => Text(
                                              dialcodeController
                                                  .codePhoneString.value,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: "email".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
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
                                TextFormField(
                                  controller: customerController.email,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle().copyWith(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                  onTapOutside: (value) =>
                                      FocusScope.of(context).unfocus(),
                                  decoration: const InputDecoration(
                                    hintText: "example@email.com",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: "birthdayDate".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
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
                                TextFormField(
                                  readOnly: true,
                                  controller: customerController.birthdayDate,
                                  onTap: () =>
                                      pickDateController.showDialogDatePicker(
                                          customerController.birthdayDate),
                                  decoration: InputDecoration(
                                    hintText: "selectDate".tr,
                                    suffixIcon: const Icon(
                                      Iconsax.calendar_1_copy,
                                      size: TSizes.iconMd,
                                      color: TColors.primary,
                                    ),
                                  ),
                                  style: const TextStyle().copyWith(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                  onTapOutside: (value) =>
                                      FocusScope.of(context).unfocus(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "address".tr,
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
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                minLines: 3,
                                maxLines: 3,
                                controller: customerController.address,
                                keyboardType: TextInputType.streetAddress,
                                style: const TextStyle().copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(
                                      customerController.maxLength.value)
                                ],
                                onChanged: (String newVal) {
                                  if (newVal.length <=
                                      customerController.maxLength.value) {
                                    customerController.text.value;
                                  } else {
                                    customerController.address.value =
                                        TextEditingValue(
                                            text: customerController.text.value,
                                            selection: TextSelection(
                                                baseOffset: customerController
                                                    .maxLength.value,
                                                extentOffset: customerController
                                                    .maxLength.value,
                                                affinity:
                                                    TextAffinity.downstream,
                                                isDirectional: false),
                                            composing: TextRange(
                                                start: 0,
                                                end: customerController
                                                    .maxLength.value));
                                    customerController.address.text =
                                        customerController.text.value;
                                  }
                                  customerController.hitung.value =
                                      newVal.length;
                                },
                                onTapOutside: (value) =>
                                    FocusScope.of(context).unfocus(),
                                decoration: InputDecoration(
                                    hintText: "customerAddress".tr,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10)),
                              ),
                              const SizedBox(height: 4),
                              Obx(
                                () => Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '${customerController.hitung.value}/${customerController.maxLength.value}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: TColors.primary),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: "province".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
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
                                TextFormField(
                                  readOnly: true,
                                  controller: customerController.province.value,
                                  onTap: () {
                                    CustomDialog.tabletDialog(
                                      (THelperFunctions.screenWidth() * 0.5),
                                      () {
                                        Get.back();
                                      },
                                      "",
                                      "province".tr,
                                      const ContentGetProvince(),
                                      false,
                                    );
                                  },
                                  style: const TextStyle().copyWith(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                  onTapOutside: (value) =>
                                      FocusScope.of(context).unfocus(),
                                  decoration: InputDecoration(
                                    hintText: "selectProvince".tr,
                                    suffixIcon: const Icon(
                                      Iconsax.arrow_square_down_copy,
                                      size: TSizes.iconMd,
                                      color: TColors.darkGrey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: "city".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
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
                                TextFormField(
                                  readOnly: true,
                                  controller: customerController.city.value,
                                  onTap: () {
                                    customerController
                                            .province.value.text.isNotEmpty
                                        ? CustomDialog.tabletDialog(
                                            (THelperFunctions.screenWidth() *
                                                0.5),
                                            () {
                                              Get.back();
                                            },
                                            "",
                                            "city".tr,
                                            const ContentGetCity(),
                                            false,
                                          )
                                        : null;
                                  },
                                  style: const TextStyle().copyWith(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                  onTapOutside: (value) =>
                                      FocusScope.of(context).unfocus(),
                                  decoration: InputDecoration(
                                    hintText: "selectCity".tr,
                                    suffixIcon: const Icon(
                                      Iconsax.arrow_square_down_copy,
                                      size: TSizes.iconMd,
                                      color: TColors.darkGrey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: "district".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
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
                                TextFormField(
                                  readOnly: true,
                                  controller: customerController.district.value,
                                  onTap: () {
                                    customerController
                                            .city.value.text.isNotEmpty
                                        ? CustomDialog.tabletDialog(
                                            (THelperFunctions.screenWidth() *
                                                0.5),
                                            () {
                                              Get.back();
                                            },
                                            "",
                                            "district".tr,
                                            const ContentGetDistrict(),
                                            false,
                                          )
                                        : null;
                                  },
                                  style: const TextStyle().copyWith(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                  onTapOutside: (value) =>
                                      FocusScope.of(context).unfocus(),
                                  decoration: InputDecoration(
                                    hintText: "selectDistrict".tr,
                                    suffixIcon: const Icon(
                                      Iconsax.arrow_square_down_copy,
                                      size: TSizes.iconMd,
                                      color: TColors.darkGrey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // RichText(
                                //     text: TextSpan(
                                //         text: "postalCode".tr,
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .titleLarge,
                                //         children: [
                                //       TextSpan(
                                //           text: '',
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .titleLarge!
                                //               .copyWith(color: TColors.primary))
                                //     ])),
                                // const SizedBox(
                                //   height: TSizes.spaceBtwInputFields - 8,
                                // ),
                                // TextFormField(
                                //   readOnly: true,
                                //   onTap: () {},
                                //   style: const TextStyle().copyWith(
                                //       fontSize: 14.0,
                                //       fontWeight: FontWeight.normal),
                                //   onTapOutside: (value) =>
                                //       FocusScope.of(context).unfocus(),
                                //   decoration: InputDecoration(
                                //     hintText: "selectPostalCode".tr,
                                //     suffixIcon: const Icon(
                                //       Iconsax.arrow_square_down_copy,
                                //       size: TSizes.iconMd,
                                //       color: TColors.darkGrey,
                                //     ),
                                //   ),
                                // ),
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
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          height: TSizes.inputFieldHeight,
          child: Obx(
            () => ElevatedButton(
              onPressed: customerController.isLoadingUpdate.value == false
                  ? () => customerController.updateCustomerRecord(
                      customerController.selectedCustomerID.value)
                  : () {},
              child: customerController.isLoadingUpdate.value == false
                  ? Text("edit".tr)
                  : TLoader.loaderButton(),
            ),
          ),
        ),
      ),
    );
  }
}
