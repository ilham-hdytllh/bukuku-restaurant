import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:restaurant_bukuku/common/widgets/custom_form/custom_form_field_no_expanded_child.dart';
import 'package:restaurant_bukuku/common/widgets/custom_outlined_button/custom_outlined_button.dart';
import 'package:restaurant_bukuku/features/promo/controllers/promo_controller.dart';
import 'package:restaurant_bukuku/features/promo/screens/widgets/add_category_content.dart';
import 'package:restaurant_bukuku/features/promo/screens/widgets/add_menu_content.dart';
import 'package:restaurant_bukuku/features/promo/screens/widgets/day_checkbox.dart';
import 'package:restaurant_bukuku/features/promo/screens/widgets/note_container.dart';
import 'package:restaurant_bukuku/features/promo/screens/widgets/radio_list_tile.dart';
import 'package:restaurant_bukuku/features/system/controller/pick_date/pick_date_controller.dart';
import 'package:restaurant_bukuku/features/system/controller/pick_time.dart/pick_time.dart';
import 'package:restaurant_bukuku/utils/constants/colors.dart';
import 'package:restaurant_bukuku/utils/constants/sizes.dart';
import 'package:restaurant_bukuku/utils/divider/horizontal_divider.dart';
import 'package:restaurant_bukuku/utils/extension/capitalize.dart';
import 'package:restaurant_bukuku/utils/helpers/helper_functions.dart';
import 'package:restaurant_bukuku/utils/loader/loader.dart';
import 'package:restaurant_bukuku/utils/popups/dialog.dart';
import 'package:restaurant_bukuku/utils/validators/validation.dart';

class UpdateProductPromoForm extends StatelessWidget {
  const UpdateProductPromoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final promoController = Get.put(PromoController());
    final pickDateController = Get.put(PickDateController());
    final pickTimeController = Get.put(PickTimeController());
    return Scaffold(
      backgroundColor: TColors.softGrey,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 60,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 300, left: 250, bottom: 10, top: 10),
                child: Form(
                  key: promoController.promoGeneral,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Edit Product Promo",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Promo Name",
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
                        controller: promoController.promoNameController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle().copyWith(
                            fontSize: 14.0, fontWeight: FontWeight.normal),
                        validator: (value) =>
                            TValidator.validateEmptyText("Promo name", value),
                        onTapOutside: (value) =>
                            FocusScope.of(context).unfocus(),
                        decoration: const InputDecoration(
                          fillColor: TColors.white,
                          filled: true,
                          hintText: "Promo Name",
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Promoted Product",
                              style: Theme.of(context).textTheme.headlineSmall,
                              children: [
                            TextSpan(
                                text: ' *',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: TColors.primary))
                          ])),
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  "Menu",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                value: "menu",
                                groupValue: promoController
                                    .selectedPromotedProduct.value,
                                activeColor: TColors.primary,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (value) {
                                  promoController
                                      .selectedPromotedProduct.value = "menu";
                                },
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "Category",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  value: "category",
                                  groupValue: promoController
                                      .selectedPromotedProduct.value,
                                  activeColor: TColors.primary,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (value) {
                                    promoController.selectedPromotedProduct
                                        .value = "category";
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => promoController.selectedPromotedProduct.value ==
                                "menu"
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    promoController.selectedMenuForPromo.length,
                                itemBuilder: (context, index) => ListTile(
                                  tileColor: TColors.white,
                                  contentPadding:
                                      const EdgeInsets.only(right: 5, left: 5),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      promoController
                                          .selectedMenuForPromo[index]
                                          .menuImage,
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    promoController
                                        .selectedMenuForPromo[index].menuName
                                        .capitalizeAll(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  subtitle: Text(
                                    "Rp ${promoController.selectedMenuForPromo[index].price.toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: TColors.primary),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () => promoController
                                        .deleteSelectedMenu(index),
                                    icon: const Icon(
                                      Iconsax.trash,
                                      color: TColors.primary,
                                      size: TSizes.iconMd,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                      Obx(
                        () => promoController.selectedPromotedProduct.value ==
                                "category"
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: promoController
                                    .selectedCategoryForPromo.length,
                                itemBuilder: (context, index) => ListTile(
                                  tileColor: TColors.white,
                                  contentPadding:
                                      const EdgeInsets.only(right: 5, left: 5),
                                  title: Text(
                                    promoController
                                        .selectedCategoryForPromo[index]
                                        .categoryName
                                        .capitalizeAll(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () => promoController
                                        .deleteSelectedCategory(index),
                                    icon: const Icon(
                                      Iconsax.trash,
                                      color: TColors.primary,
                                      size: TSizes.iconMd,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                      Obx(
                        () => promoController.selectedPromotedProduct.value ==
                                "menu"
                            ? GestureDetector(
                                onTap: () {
                                  CustomDialog.tabletDialog(
                                      (THelperFunctions.screenWidth() * 0.45),
                                      () {},
                                      "",
                                      "Menu",
                                      const GetMenuContent(),
                                      false);
                                },
                                child: CustomOutlinedButton(
                                  borderColor: TColors.primary,
                                  height: TSizes.inputFieldHeight,
                                  child: Text(
                                    "+ Add Menu",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  CustomDialog.tabletDialog(
                                      (THelperFunctions.screenWidth() * 0.45),
                                      () {},
                                      "",
                                      "Category",
                                      const GetCategoryContent(),
                                      false);
                                },
                                child: CustomOutlinedButton(
                                  borderColor: TColors.primary,
                                  height: TSizes.inputFieldHeight,
                                  child: Text(
                                    "+ Add Category",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const CustomHorizontalDivider(),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Discount Amount",
                              style: Theme.of(context).textTheme.headlineSmall,
                              children: [
                            TextSpan(
                                text: ' *',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: TColors.primary))
                          ])),
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  "Amount (Rp)",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                value: "amount",
                                groupValue:
                                    promoController.selectedDiscountType.value,
                                activeColor: TColors.primary,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (value) {
                                  promoController.selectedDiscountType.value =
                                      "amount";
                                },
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "Percentage (%)",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  value: "percent",
                                  groupValue: promoController
                                      .selectedDiscountType.value,
                                  activeColor: TColors.primary,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (value) {
                                    promoController.selectedDiscountType.value =
                                        "percent";
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return promoController.selectedDiscountType.value ==
                                "amount"
                            ? TextFormField(
                                controller:
                                    promoController.discountAmountController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle().copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal),
                                onTapOutside: (value) =>
                                    FocusScope.of(context).unfocus(),
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        "Value discount", value),
                                decoration: InputDecoration(
                                  fillColor: TColors.white,
                                  filled: true,
                                  prefixIcon: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 60,
                                    decoration: const BoxDecoration(
                                        color: TColors.grey,
                                        borderRadius: BorderRadius.only(
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
                              )
                            : TextFormField(
                                keyboardType: TextInputType.number,
                                style: const TextStyle().copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal),
                                controller:
                                    promoController.discountPercentController,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        "Value discount", value),
                                onTapOutside: (value) =>
                                    FocusScope.of(context).unfocus(),
                                decoration: InputDecoration(
                                  fillColor: TColors.white,
                                  filled: true,
                                  suffixIcon: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    width: 60,
                                    decoration: const BoxDecoration(
                                        color: TColors.grey,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                    child: const Center(
                                      child: Text(
                                        "%",
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                      }),
                      Obx(
                        () => promoController.selectedDiscountType.value ==
                                "percent"
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: TSizes.spaceBtwInputFields,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          text: "Maximum Discount (Optional)",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                          children: [
                                        TextSpan(
                                            text: '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    color: TColors.primary))
                                      ])),
                                  const SizedBox(
                                    height: TSizes.spaceBtwInputFields - 8,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle().copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal),
                                    controller: promoController
                                        .maximumDiscountController,
                                    onTapOutside: (value) =>
                                        FocusScope.of(context).unfocus(),
                                    decoration: InputDecoration(
                                      fillColor: TColors.white,
                                      filled: true,
                                      prefixIcon: Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        width: 60,
                                        decoration: const BoxDecoration(
                                            color: TColors.grey,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                bottomLeft:
                                                    Radius.circular(5))),
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
                                  // notice if this optional
                                  const NoteContainer(
                                    text: "Default maximum discount is zero",
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      Obx(
                        () => CheckboxListTile(
                            contentPadding: const EdgeInsets.only(left: 0),
                            title: Text(
                              "Applies with Multiple Purchases",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: promoController
                                .appliesWithMultiplePurchases.value,
                            onChanged: (value) {
                              promoController
                                      .appliesWithMultiplePurchases.value =
                                  !promoController
                                      .appliesWithMultiplePurchases.value;

                              promoController.multiplePurchasesQty.clear();
                            }),
                      ),
                      Obx(
                        () => promoController
                                    .appliesWithMultiplePurchases.value ==
                                true
                            ? const SizedBox(
                                height: TSizes.spaceBtwText,
                              )
                            : const SizedBox(),
                      ),
                      Obx(
                        () => TextFormField(
                          readOnly: !promoController
                              .appliesWithMultiplePurchases.value,
                          controller: promoController.multiplePurchasesQty,
                          keyboardType: TextInputType.number,
                          style: const TextStyle().copyWith(
                              fontSize: 14.0, fontWeight: FontWeight.normal),
                          onTapOutside: (value) =>
                              FocusScope.of(context).unfocus(),
                          decoration: const InputDecoration(
                            fillColor: TColors.white,
                            filled: true,
                            hintText: "Max quantity",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const CustomHorizontalDivider(),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Apply Promo On",
                              style: Theme.of(context).textTheme.headlineSmall,
                              children: [
                            TextSpan(
                                text: ' *',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: TColors.primary))
                          ])),
                      Obx(
                        () => CustomRadioListTile(
                          title: "Always Active",
                          grupValue: promoController.promotionActiveType.value,
                          value: "always",
                          onChanged: (value) {
                            promoController.promotionActiveType.value =
                                "always";
                          },
                        ),
                      ),
                      Obx(
                        () => CustomRadioListTile(
                          title: "Select Date Period",
                          grupValue: promoController.promotionActiveType.value,
                          value: "period",
                          onChanged: (value) {
                            promoController.promotionActiveType.value =
                                "period";
                          },
                        ),
                      ),
                      Obx(
                        () => promoController.promotionActiveType.value ==
                                "period"
                            ? const SizedBox(
                                height: TSizes.spaceBtwInputFields,
                              )
                            : const SizedBox(),
                      ),
                      Obx(
                        () => promoController.promotionActiveType.value ==
                                "period"
                            ? Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      readOnly: true,
                                      controller:
                                          promoController.startDateController,
                                      validator: (value) =>
                                          TValidator.validateEmptyText(
                                              "Start date", value),
                                      onTap: () => pickDateController
                                          .showDialogDatePicker(promoController
                                              .startDateController),
                                      decoration: InputDecoration(
                                        fillColor: TColors.white,
                                        filled: true,
                                        hintText: "Start date".tr,
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
                                  ),
                                  const SizedBox(
                                    width: TSizes.spaceBtwInputFields,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      readOnly: true,
                                      controller:
                                          promoController.endDateController,
                                      onTap: () => pickDateController
                                          .showDialogDatePicker(promoController
                                              .endDateController),
                                      validator: (value) =>
                                          TValidator.validateEmptyText(
                                              "End date", value),
                                      decoration: InputDecoration(
                                        fillColor: TColors.white,
                                        filled: true,
                                        hintText: "End date".tr,
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
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ),
                      Obx(
                        () => CustomRadioListTile(
                          title: "Selected Days",
                          grupValue: promoController.promotionActiveType.value,
                          value: "days",
                          onChanged: (value) {
                            promoController.promotionActiveType.value = "days";
                          },
                        ),
                      ),
                      Obx(
                        () =>
                            promoController.promotionActiveType.value == "days"
                                ? const SizedBox(
                                    height: TSizes.spaceBtwInputFields,
                                  )
                                : const SizedBox(),
                      ),
                      Obx(
                        () =>
                            promoController.promotionActiveType.value == "days"
                                ? CustomFormFieldNoExpandedChild(
                                    roleController: promoController,
                                    initialValue:
                                        promoController.anyPermissionSelected(),
                                    autovalidateMode: AutovalidateMode.disabled,
                                    validator: (value) =>
                                        TValidator.validateEmptyCheckbox(
                                            "Please choose one",
                                            promoController
                                                .anyPermissionSelected()),
                                    page: const DaysCheckbox(),
                                  )
                                : const SizedBox(),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const CustomHorizontalDivider(),
                      Obx(
                        () => CheckboxListTile(
                          contentPadding: const EdgeInsets.only(left: 0),
                          title: Text(
                            "Select Promotion Hours",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: promoController.selectedPromotionHour.value,
                          onChanged: (value) =>
                              promoController.selectedPromotionHour.value =
                                  !promoController.selectedPromotionHour.value,
                        ),
                      ),
                      Obx(
                        () =>
                            promoController.selectedPromotionHour.value == true
                                ? const SizedBox(
                                    height: TSizes.spaceBtwText,
                                  )
                                : const SizedBox(),
                      ),
                      Obx(
                        () => promoController.selectedPromotionHour.value ==
                                true
                            ? Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      readOnly: true,
                                      controller:
                                          promoController.startHourController,
                                      onTap: () => pickTimeController
                                          .showDialogDatePicker(promoController
                                              .startHourController),
                                      validator: (value) =>
                                          TValidator.validateEmptyText(
                                              "Start time", value),
                                      decoration: InputDecoration(
                                        fillColor: TColors.white,
                                        filled: true,
                                        hintText: "".tr,
                                        suffixIcon: const Icon(
                                          Iconsax.clock_copy,
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
                                  ),
                                  const SizedBox(
                                    width: TSizes.spaceBtwInputFields,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      readOnly: true,
                                      controller:
                                          promoController.endHourController,
                                      onTap: () => pickTimeController
                                          .showDialogDatePicker(promoController
                                              .endHourController),
                                      validator: (value) =>
                                          TValidator.validateEmptyText(
                                              "End time", value),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: TColors.white,
                                        hintText: "".tr,
                                        suffixIcon: const Icon(
                                          Iconsax.clock_copy,
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
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: TColors.white,
              width: double.infinity,
              height: TSizes.inputFieldHeight + 20,
              child: Obx(
                () => ElevatedButton(
                  onPressed: promoController.isLoadingUpdate.value == false
                      ? () => promoController.savePromo()
                      : () {},
                  child: promoController.isLoadingUpdate.value == false
                      ? Text("edit".tr)
                      : TLoader.loaderButton(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 15,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () => Get.back(id: 3),
                  icon: const Icon(
                    Iconsax.arrow_left_copy,
                    size: 28,
                    color: TColors.primary,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
