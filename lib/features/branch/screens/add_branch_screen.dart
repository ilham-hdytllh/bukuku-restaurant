import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/address_from_maps/pick_address.dart';
import 'package:restaurant_bukuku/common/widgets/dial_code_dropdown/dial_code_dropdown.dart';
import 'package:restaurant_bukuku/features/branch/controllers/branch_controller.dart';
import 'package:restaurant_bukuku/features/system/controller/address_from_map/address_from_map.dart';
import 'package:restaurant_bukuku/features/system/controller/dialcode/dialcode_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class AddBranchScreen extends StatelessWidget {
  const AddBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dialcodeController = Get.put(DialCodeController());
    final branchController = Get.put(BranchController());
    final addressFromMapController = Get.put(AddressFromMapController());

    return Scaffold(
      backgroundColor: TColors.softGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: branchController.branchFormKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () => Get.back(id: 6),
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
                                        text: "Outlet Name",
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
                                Obx(
                                  () => TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller:
                                        branchController.branchName.value,
                                    validator: (value) =>
                                        TValidator.validateEmptyText(
                                            "Outlet Name", value),
                                    decoration: const InputDecoration(
                                        hintText: "Ex: Resto Me"),
                                    style: const TextStyle().copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal),
                                    onTapOutside: (value) =>
                                        FocusScope.of(context).unfocus(),
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
                                        text: "Outlet Phone Number",
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
                                Obx(
                                  () => TextFormField(
                                    keyboardType: TextInputType.phone,
                                    style: const TextStyle().copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal),
                                    validator: (value) =>
                                        TValidator.validatePhoneNumber(value),
                                    onTapOutside: (value) =>
                                        FocusScope.of(context).unfocus(),
                                    controller:
                                        branchController.branchPhoneNo.value,
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
                                                      topLeft:
                                                          Radius.circular(5),
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
                                        text: "Email for Daily Report",
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
                                Obx(
                                  () => TextFormField(
                                    controller:
                                        branchController.branchEmail.value,
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
                                        text: "Branch Address",
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
                                Obx(
                                  () => TextFormField(
                                    readOnly: true,
                                    onTap: () {
                                      Get.to(const PickerAdress());
                                    },
                                    controller: addressFromMapController
                                        .addressFromMap.value,
                                    validator: (value) =>
                                        TValidator.validateEmptyText(
                                            "Branch Address", value),
                                    style: const TextStyle().copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal),
                                    onTapOutside: (value) =>
                                        FocusScope.of(context).unfocus(),
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
              onPressed: branchController.isLoadingAdd.value == false
                  ? () => branchController.saveBranchToFirestore()
                  : null,
              child: branchController.isLoadingAdd.value == false
                  ? Text("add".tr)
                  : const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 26,
                            width: 26,
                            child: CircularProgressIndicator(
                              color: TColors.darkGrey,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Please wait..."),
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
