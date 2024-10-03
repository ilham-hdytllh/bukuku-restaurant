import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/select_role/select_role_content.dart';
import 'package:restaurant_bukuku/features/employe/controller/employes/employee_controller.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class UpdateEmployeScreen extends StatelessWidget {
  const UpdateEmployeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employeController = Get.put(EmployeController());

    return Scaffold(
      backgroundColor: TColors.softGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: employeController.employeFormkey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () => Get.back(id: 4),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "Name",
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
                            controller: employeController.employeName,
                            validator: (value) =>
                                TValidator.validateEmptyText("Name", value),
                            decoration: const InputDecoration(
                                hintText: "Ex: Awok Helix"),
                            style: const TextStyle().copyWith(
                                fontSize: 14.0, fontWeight: FontWeight.normal),
                            onTapOutside: (value) =>
                                FocusScope.of(context).unfocus(),
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
                                  text: "email".tr,
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
                            controller: employeController.employeEmail,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                TValidator.validateEmail(value),
                            style: const TextStyle().copyWith(
                                fontSize: 14.0, fontWeight: FontWeight.normal),
                            onTapOutside: (value) =>
                                FocusScope.of(context).unfocus(),
                            decoration: const InputDecoration(
                              hintText: "example@email.com",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: "Role",
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
                                  readOnly: true,
                                  controller: employeController.employeRole,
                                  validator: (value) =>
                                      TValidator.validateEmptyText(
                                          "Name", value),
                                  onTap: () {
                                    CustomDialog.tabletDialog(
                                        (THelperFunctions.screenWidth() * 0.45),
                                        () {},
                                        "Select",
                                        "Role",
                                        SelectRoleContent(
                                          controller:
                                              employeController.employeRole,
                                        ),
                                        false);
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Role",
                                    suffixIcon: Icon(
                                      Iconsax.arrow_square_down_copy,
                                      size: TSizes.iconMd,
                                      color: TColors.darkGrey,
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
                                        text: "PIN",
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
                                    controller: employeController.employePIN,
                                    keyboardType: TextInputType.number,
                                    validator: (value) =>
                                        TValidator.validateEmptyText(
                                            "PIN", value),
                                    style: const TextStyle().copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(5)
                                    ],
                                    onTapOutside: (value) =>
                                        FocusScope.of(context).unfocus(),
                                    obscureText:
                                        employeController.hidePassword.value,
                                    obscuringCharacter: "*",
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () => employeController
                                                  .hidePassword.value =
                                              !employeController
                                                  .hidePassword.value,
                                          icon: Icon(employeController
                                                      .hidePassword.value ==
                                                  true
                                              ? Iconsax.eye_slash_copy
                                              : Iconsax.eye_copy),
                                        ),
                                        hintText: "PIN",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10)),
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
              onPressed: employeController.isLoadingUpdate.value == false
                  ? () => employeController.updateEmployeRecord(
                      employeController.selectedEmployeID.value)
                  : () {},
              child: employeController.isLoadingUpdate.value == false
                  ? Text("edit".tr)
                  : TLoader.loaderButton(),
            ),
          ),
        ),
      ),
    );
  }
}
