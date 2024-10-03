import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_bukuku/common/widgets/category_content/category_content.dart';
import 'package:restaurant_bukuku/common/widgets/custom_back_button/custom_back_button.dart';
import 'package:restaurant_bukuku/common/widgets/pick_image/pick_image_menu.dart';
import 'package:restaurant_bukuku/features/menu_and_category/controllers/menu_controller.dart';
import 'package:restaurant_bukuku/features/menu_and_category/screens/menu/widgets/update_button.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/image_strings.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class UpdateMenuScreen extends StatelessWidget {
  const UpdateMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(MenuProductController());
    return Scaffold(
      backgroundColor: TColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Form(
          key: menuController.menuFormkey,
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // back button
                        CustomBackButton(
                          onTap: () => Get.back(id: 2),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                menuController.imageMenu.value == null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          menuController.selectedImage.value,
                                          height: 95,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          menuController.imageMenu.value!,
                                          height: 95,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: TColors.darkGrey),
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
                                          menuController
                                              .getMenuImageFromGallery();
                                        },
                                        onTap2: () {
                                          menuController
                                              .getMenuImageFromCamera();
                                        },
                                      ),
                                      false,
                                    );
                                  },
                                  child: Text(
                                      menuController.imageMenu.value == null
                                          ? "Ambil Gambar"
                                          : "Ganti Gambar"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Menu Name",
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
                          controller: menuController.menuName,
                          validator: (value) =>
                              TValidator.validateEmptyText("Name", value),
                          decoration:
                              const InputDecoration(hintText: "Ex: Spaghetti"),
                          style: const TextStyle().copyWith(
                              fontSize: 14.0, fontWeight: FontWeight.normal),
                          onTapOutside: (value) =>
                              FocusScope.of(context).unfocus(),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Category",
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
                        TextFormField(
                          readOnly: true,
                          controller: menuController.menuCategory,
                          onTap: () {
                            CustomDialog.tabletDialog(
                              (THelperFunctions.screenWidth() * 0.5),
                              () {
                                Get.back();
                              },
                              "select".tr,
                              "Category",
                              CategoryContent(
                                controller: menuController.menuCategory,
                              ),
                              false,
                            );
                          },
                          decoration: const InputDecoration(
                              hintText: "-- Select category --"),
                          style: const TextStyle().copyWith(
                              fontSize: 14.0, fontWeight: FontWeight.normal),
                          onTapOutside: (value) =>
                              FocusScope.of(context).unfocus(),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Price",
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
                          keyboardType: TextInputType.number,
                          style: const TextStyle().copyWith(
                              fontSize: 14.0, fontWeight: FontWeight.normal),
                          onTapOutside: (value) =>
                              FocusScope.of(context).unfocus(),
                          validator: (value) =>
                              TValidator.validateEmptyText("Price", value),
                          controller: menuController.price,
                          decoration: InputDecoration(
                            prefixIcon: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 60,
                              decoration: BoxDecoration(
                                  color: TColors.softGrey,
                                  border: Border.all(
                                      width: 1, color: TColors.borderPrimary),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))),
                              child: const Center(
                                child: Text(
                                  "Rp",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: TColors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Allow Flexible Price",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Obx(
                                () => Switch(
                                  value:
                                      menuController.allowFlexiblePrice.value,
                                  onChanged: (value) => menuController
                                      .allowFlexiblePrice.value = value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Description",
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
                      TextFormField(
                        controller: menuController.description,
                        decoration: const InputDecoration(hintText: ""),
                        style: const TextStyle().copyWith(
                            fontSize: 14.0, fontWeight: FontWeight.normal),
                        onTapOutside: (value) =>
                            FocusScope.of(context).unfocus(),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: TColors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tambah Addon",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                SizedBox(
                                  width: 120,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: TColors.darkGrey),
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
                                        "Select",
                                        "Addons",
                                        const SizedBox(),
                                        true,
                                      );
                                    },
                                    child: const Text("Pilih Addon"),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            Image.asset(
                              TImages.addonIcon,
                              height: 85,
                              fit: BoxFit.fitHeight,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: TColors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add Recipe",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                SizedBox(
                                  width: 120,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: TColors.darkGrey),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: TSizes.buttonHeight - 10,
                                          horizontal: 20),
                                    ),
                                    onPressed: () {},
                                    child: const Text("Add Recipe"),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            Image.asset(
                              TImages.recipeIcon,
                              height: 85,
                              fit: BoxFit.fitHeight,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const UpdateMenuButton(),
    );
  }
}
